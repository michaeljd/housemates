module StatisticsHelper
  def chart_tag (data_path, height, params = {})
    params[:format] ||= :json
    content_tag(:div, :'data-chart' => data_path, :style => "height: #{height}px;") do
      image_tag('spinner.gif', :size => '24x24', :class => 'spinner')
    end
  end
end
