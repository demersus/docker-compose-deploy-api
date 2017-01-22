class ServicesController < ApplicationController
  def deploy
    service = Service.find(params[:id])
    hooks = service.hooks.where(action_type: 'deploy')

    Thread.new do
      if service.deploy
        hooks.each do |h|
          h.perform
        end
      end
    end

    render plain: "started", status: 202
  end

  def start
    service = Service.find(params[:id])
    if service.start
      render plain: "ok"
    else
      render plain: "fail", status: 500
    end
  end

  def stop
    service = Service.find(params[:id])
    if service.stop
      render plain: "ok"
    else
      render plain: "fail", status: 500
    end
  end

  def logs
    service = Service.find(params[:id])

    render plain: service.logs(params[:tail])
  end
end
