class TasksController < ApplicationController
  
  # index(一覧表示orユーザに対するタスク取得のみ、未ログインでも許可)
  # -> view側で出し分けている。

  before_action :require_user_logged_in, only: [:new, :create]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    #@tasks = Task.all
    
    # ユーザに対するタスクを取得
    if logged_in?
      @user = current_user
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    else
      #　ログインフォームの出力処理
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    # @task = Task.new(task_params)
    
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit
  end

  def update

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private

  # Strong Parameter
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def correct_user
    redirect_to root_url if @task.user != current_user
  end
end
