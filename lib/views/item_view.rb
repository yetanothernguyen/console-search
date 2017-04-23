require "tty-table"

class ItemView
  def initialize(prompt, item, presenter)
    @prompt         = prompt
    @item           = item
    @presented_item = presenter.new(item)
    @done           = false

    @prompt.subscribe(self)
  end

  def keypress(event)
    return unless event.key.name == :backspace
    @done = true
  end

  def render
    @prompt.print(@prompt.hide)
    loop do
      item_table = render_item_table
      @prompt.print(item_table)
      @prompt.read_keypress
      @prompt.print(refresh(item_table.lines.count + 1))
      break if done
    end
  end

  def done
    @done
  end

  private

  def refresh(lines_count)
    @prompt.clear_lines(lines_count)
  end

  def render_item_table
    table = TTY::Table.new header: ["Field", "Value"], rows: @presented_item.details
    rendered_table = table.render(:unicode, padding: [0, 2])
    rendered_table += "\n(Use Backspace to go back to search results)\n"
    rendered_table
  end
end
