module ApplicationHelper

  def vote_buttons(resource, up_url, down_url)
    options = {}
    options[:resource] = resource
    options[:up_url] = up_url
    options[:down_url] = down_url

    render inline: <<-HAML.strip_heredoc, type: :haml, locals: options
      .btn-block.js-vote-count
        = link_to up_url, method: :post, remote: true do
          %i{class: "vote-arrow-style glyphicon glyphicon-chevron-up"}
      .btn-block.js-vote-score
        %span{class: "badge "}=resource.sum_votes
      .btn-block.js-vote-count
        = link_to down_url, method: :delete, remote: true do
          %i{class: "vote-arrow-style glyphicon glyphicon-chevron-down"}
    HAML
  end
end
