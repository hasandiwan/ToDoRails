# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test 'resets tasks due today' do
    task2 = Marshal.load(Marshal.dump(@task))
    task2.due_on = Date.today
    get '/clean'
    assert_response :success
    assert response.body.end_with?(' incomplete records have their due dates updated')
  end
  test 'should update one' do
    task2 = Marshall.load(Marshall.dump(@task))
    task2.due_on(DateTime.now)
    task2.id = nil
    task2.save!
    head tasks_url
    assert_response :success
    assert response.header['x-count'] == 2
  end

  test 'should get index' do
    get tasks_url
    assert_response :success
  end

  test 'should get new' do
    get new_task_url
    assert_response :success
  end

  test 'should create task' do
    assert_difference('Task.count') do
      post tasks_url,
           params: { task: { completed: @task.completed, due_date: @task.due_date, title: @task.title,
                             user_id: @task.user_id } }
    end

    assert_redirected_to task_url(Task.last)
  end

  test 'should show task' do
    get task_url(@task)
    assert_response :success
  end

  test 'should get edit' do
    get edit_task_url(@task)
    assert_response :success
  end

  test 'should update task' do
    patch task_url(@task),
          params: { task: { completed: @task.completed, due_date: @task.due_date, title: @task.title,
                            user_id: @task.user_id } }
    assert_redirected_to task_url(@task)
  end

  test 'should destroy task' do
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
  end
end
