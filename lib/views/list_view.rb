require "tty-table"
require "kaminari/core"
require "kaminari/activerecord"

require "views/item_view"

class ListView

  PAGE_SIZE = 10

  def initialize(prompt, items, presenter)
    @prompt       = prompt
    @items        = items
    @presenter    = presenter
    @done         = false
    @exit         = false
    @render_child = false
    @current_page = 1
    @current_row  = 1
    @no_results   = items.empty?
    @pastel       = Pastel.new

    @prompt.subscribe(self)
  end

  def exit?
    @exit
  end

  def total_pages
    @total_pages ||= @items.total_pages
  end

  def keypress(event)
    return if @done

    if event.value == "q"
      @done = true
      @exit = true
    elsif event.value == "s"
      @done = true
      @exit = false
    elsif event.key.name == :return
      @render_child = true
    end
  end

  def keyup(*)
    return if @done
    @current_row = @current_row == 1 ? result_page_size : @current_row - 1
  end

  def keydown(*)
    return if @done
    @current_row = @current_row == result_page_size ? 1 : @current_row + 1
  end

  def keyleft(*)
    return if @done
    @current_page = @current_page == 1 ? total_pages : @current_page - 1
    @current_row = 1
  end

  def keyright(*)
    return if @done
    @current_page = @current_page == total_pages ? 1 : @current_page + 1
    @current_row = 1
  end

  def render
    @prompt.print(@prompt.hide)
    loop do
      list = render_list
      @prompt.print(list)
      @prompt.read_keypress
      @prompt.print(refresh(list.lines.count + 1))
      render_child if @render_child
      break if done
    end
  ensure
    @prompt.print(@prompt.show)
  end

  def done
    @done
  end

  private

  def render_list
    if @no_results
      return "No results found" + render_footer_exit_help
    end

    @items = @items.page(@current_page).per(PAGE_SIZE)
    table = TTY::Table.new header: @presenter.listing_header, rows: render_rows(@items)
    rendered_table = table.render(:unicode, padding: [0, 2])
    rendered_table << render_footer
  end

  def render_rows(items)
    items.each_with_index.map do |item, index|
      row = @presenter.new(item).listing_row
      row = row.map { |i| @pastel.green(i) } if index + 1 == @current_row
      row
    end
  end

  def render_footer
    render_footer_count +
      render_footer_pages +
      render_footer_help
  end

  def render_footer_count
    "\nShowing #{@items.offset_value + 1}-#{[(@items.offset_value + @items.limit_value), @items.total_count].min} of #{@items.total_count} items"
  end

  def render_footer_pages
    pages = ""
    (1..total_pages).each do |index|
      page = index == @current_page ? @pastel.green(index) : index.to_s
      pages += page + " "
    end
    "\nPage: #{pages}"
  end

  def render_footer_help
    "\n" +
      @pastel.bright_black("(Use up and down, left and right to nagivate between result items and pages)") +
      "\n" +
      @pastel.bright_black("(Enter to view details of a result item)") +
      render_footer_exit_help
  end

  def render_footer_exit_help
    "\n" +
      @pastel.bright_black("(s to perform new search)") +
      "\n" +
      @pastel.bright_black("(q to exit)") +
      "\n"
  end

  def render_child
    @done = true

    item_view = ItemView.new(@prompt, current_item, @presenter)
    item_view.render

    @render_child = false
    @done = false
  end

  def refresh(lines_count)
    @prompt.clear_lines(lines_count)
  end

  def current_item
    @items[@current_row - 1]
  end

  def result_page_size
    @result_page_size ||= [@items.total_count, PAGE_SIZE].min
  end
end
