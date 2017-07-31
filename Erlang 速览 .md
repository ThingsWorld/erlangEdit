## Erlang 速览 

1.  Shell

   ```erlang
   用户输入表达式，shell就会执行这条表达式并显示出结果、
   shi@shi-shiyuegame:~/share/erlangDir$ erl
   Erlang/OTP 19 [erts-8.2] [source] [64-bit] [async-threads:10] [hipe] [kernel-poll:false]

   Eshell V8.2  (abort with ^G)
   1> X = 123
   1> .  %不要忘了表达式要以点为结束标志
   123
   2>    
   ```

2. = 操作符

   ```erlang
   1> A = 1.
   1
   2> A = 2.   #当你试图改变之前变量的值，会报错。
   ** exception error: no match of right hand side value 2
   3> 
   %总结： 变量的首字母必须是以大写开头，而且变量一但绑定，不能再修改。Erlang是一种函数式语言（没有变量的赋值行为，讲究的是引用透明性，也就是说一个表达式返回一个值，那么它永远返回一个值，不会变。）
   ```

3. 变量和原子的语法

   ```erlang
   %Erlang 变量以大写字母开头。比如 X、A、和 H_b_s等都是变量，以小写字母开头的名称，比如monday等不是变量，而是符号常量，称为原子（atom）。重要的是不要混淆变量和原子。（变量和符号常量）
   ```

4. 进程、模块、编译

   ```shell
   Erlang程序由许多并行的进程构成。
   进程：负责执行模块里定义的函数；
   模块：扩展名为 .erl 的文件
   编译：编译生成 .bre
   ```

5. 在shell里编译并运行 hello world

   ```erlang
   1> c(hello)
   1> .  %不要忘了句点为表达式结束标志
   {ok,hello}
   2> hello:start().
   hello world
   ok
   #在shell外面编译
   shi@shi-shiyuegame:~/ErlangStudy/hello$ erlc hello.erl 
   shi@shi-shiyuegame:~/ErlangStudy/hello$ erl -noshell -s hello start -s init stop
   ```

6. 并发举例

   ```erlang
   %服务器端进程
   -module(afile_server).
   -export([start/1,loop/1]).

   %在erlang里，通过spawn 运行某个模块里定义的函数创建一个新进程
   start(Dir) -> spawn(afile_server, loop, [Dir]).

   loop(Dir) -> 		%loop函数永远不会返回。
   	receive 		%所有接收的消息包含变量Client，它是发送请求进程的进程标识符。也是该回复的对象
   	{Client, list_dir} ->   
   		Client ! {self() ,file:list_dir(Dir)};
   	{Client, {get_file,File}} ->
   		Full = filename:join(Dir, File),
         %self() 服务器发送，在这个例子self（）是服务器进程标识符
   		Client ! {self() ,file:read_file(Full)}   
   	end,
   	loop(Dir).
   ```


   ​

   ```erlang
      %客户端进程

      -module(afile_client).

      -export([ls/1,get_file/2]).

      ls(Server) -> 

      	Server ! {self(), list_dir},

      	receive

      	     {Server, FileList} -> 
      		FileList
      	end.

      get_file(Server, File) -> 

      	Server ! {self(),{get_file,File}},

      	receive

      		{Server, Content} -> 

      			Content

      	end.

      %在shell测试服务端和客户端：

      1> c(afile_server).

      {ok,afile_server}

      2> c(afile_client).

      {ok,afile_client}

      3> FileServer = afile_server:start(".").

      <0.70.0>

      4> afile_client:get_file(FileServer,"missing").

      {error,enoent}

      5> afile_client:get_file(FileServer,"afile_server.erl").  %显示afile_server.erl里面的文件内容

      {ok,<<"-module(afile_server).\n-export([start/1,loop/1]).\n\nstart(Dir) -> spawn(afile_server, loop, [Dir]).\n\nloop(Dir"...>>}         

   ```

      

