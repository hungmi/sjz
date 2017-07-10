class Admin::IsoDocsController < Admin::DocsController
  def index
    @docs = Doc.iso.order(updated_at: :desc).ransack(params[:q]).result
    render template: "admin/docs/index"
  end

  def new
    @doc = Doc.new(iso: true)
  end

  private

    def find_doc
      @doc = Doc.iso.find(params[:id])
    end
end