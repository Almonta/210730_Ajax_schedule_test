class SchedulesController < ApplicationController
  before_action :set_blog, only: [:create, :edit, :update]
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    # @blog = Blog.find(params[:blog_id])
    @schedule = @blog.schedules.build(schedule_params)
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @schedule.save
        # format.html { redirect_to blog_path(@blog) }
        format.js { render :index }
      else
        format.html { redirect_to blog_path(@blog), notice: '投稿できませんでした...' }
      end
    end
  end

  def edit
    @schedule = @blog.schedules.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = 'コメントの編集中'
      format.js { render :edit }
    end
  end

  def update
    @schedule = @blog.schedules.find(params[:id])
    respond_to do |format|
      if @schedule.update(schedule_params)
        flash.now[:notice] = 'コメントが編集されました'
        format.js { render :index }
      else
        flash.now[:notice] = 'コメントの編集に失敗しました'
        format.js { render :edit_error }
      end
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    respond_to do |format|
      flash.now[:notice] = 'コメントが削除されました'
      format.js { render :index }
    end
  end

  private
  # ストロングパラメーター
  def schedule_params
    params.require(:schedule).permit(:blog_id, :serial_number, :line_on)
  end

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

end
