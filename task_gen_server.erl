%%----------------------------------------------------
%% gen_server模板
%% 
%% @author hebishi@shiyuegmail.com
%%----------------------------------------------------
-module(task_gen_server).
-behaviour(gen_server).

-export([start_link/0]).
%% gen_server 模板中六个函数
-export([ init/1
				, handle_call/3
				, handle_cast/2
				, handle_info/2
				, terminate/2
				, code_change/3]).

%% 开始服务器。gen_server:start_link 是同步的。带start_link跟父进程链接
%% @arg1 {local,?MODULE} 指定服务器名字，本地注册
%% @arg2 ?MODULE 回调这个模块名字的函数
%% @arg3 [] 是一个原子，原样传递给回调函数初始化。 
%% @arg4 [] 是一个列表选项。
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


%% 如果名字注册成功,gen_server产生新的进程会调用这个init([])回调函数。
init([]) ->
%% 如果想要调用terminate/2 实现all_for_one监控树
%% 就必须设置trap_exit 为 true
    process_flag(trap_exit, true),  
    %% State 可用通道
    {ok, State}.                  

%% 同步请求 handle_call 对应 gen_server:call
%% 当接收到一个请求，就调用handle_call()
handle_call(_Request, _From, State) ->
    {noreply, State}.

%% 异步请求 handle_cast 对应 gen_server:cast
handle_cast(_Msg, State) ->
    {noreply, State}.

%% 处理其他信息
handle_info(_Info, State) ->
		%% 这里写其他处理信息
		{noreply, State}.

%% 清理退出
terminate(_Reason, _State) ->
		%% 这里主要写清理收尾工作
    ok.

%% 热代码替换，不停机维护
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

