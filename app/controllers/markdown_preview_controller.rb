class MarkdownPreviewController < ApplicationController

  def preview
    @text = params[:text]
    respond_to do |format|
      format.js { render "shared/markdown_preview" }
    end
  end

end
