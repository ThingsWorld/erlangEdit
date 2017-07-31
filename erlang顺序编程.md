1. ### 浮点数

   ```erlang
   erlang在内部使用64位的IEEE 754-1985浮点数，跟c语言一样的浮点数与精度的问题
   ```

2. ### 原子

   ```erlang
   在erlang里，原子被用于表示常量值。
   原子是全局性的，而且不需要宏定义或包含文件就能实现。
   原子以小写字母开头、后接一串字母、数字、下划线或 @符号。
   原子还可以放在单引号 (') 内。
   ```

3. ### 元组

   ```erlang
   元组：把一些固定的项目归组成单一的实体。类似C语言的struct.
   比如：{hebi,shi}
   字符串必须以双引号表示。
   ```

4. ### 列表

   ```erlang
   %创建列表：用中括号把列表的元素括起来，并用逗号隔开。
   %如果T 是一个列表，那么 [H|T] 也是一个列表，它的头是H，尾是T 。
   %列表推导：
   [2*X || X <- L]. %% || 右侧 X <- L  X从列表L中提取出来， 2*X中X 的列表是 L的。
   ```

5. ### 模式匹配

   ```erlang
   {X,abc} = {123,abc}				%成功： X = 123
   {X,Y,Z} = {222,def,"cat"}		%成功： X = 222, Y = def, Z = "cat"
   {X,Y} 	= {33,jj,"cat"}			%失败： 元组的形状不同
   X = true						%成功：X = true
   {X,Y,Z} = {{abc,12},44,"cat"}	%成功：X = {abc,12}, Y = 44, Z = "cat"
   {X,Y,X} = {{abc,12},44,"cat"} 	%失败： X不能即是{abc,12},又是"cat"
   [H|T] = [1,2,3,4]				%成功： H = 1, T = [2,3,4]
   [H|T] = "cat"					%成功： H = 99(字符集），T = "at"
   [A,B,C|T] = [a,b,c,d,e,f]		%成功： A = a,B = b,C = c, T = [d,e,f]
   ```

6. ### 模块与函数

   ```erlang
   %erlang的文件名
   %filename.erl 
   -module(filename). 	%模块
   -export([area/1]).	%函数

   area({rectangle,Width,Height})	-> Width * Height;		%函数声明
   area({square,Side})				-> Side  * Side.		
   ```

7. ### fun : 基本的抽象单元

   ```erlang
   % erlang 是一种函数式语言。
   % funs是 "匿名" 的函数。
   % fun 可以有任意数量的参数。
   % 可通过下列方式访问
      	1.对列表里的每一个元素执行相同的操作。
   		示例： 
   			1> L = [1,2,5,7].
   			[1,2,5,7]
   			2> lists:map(fun(X) -> 2*X end, L).
   			[2,4,10,14]
   			3> 

   	2.创建自己的控制抽象。erlang没有for循环，则可以使用函数和递归来实现。
   		%文件名为： lib_misc.erl
   			-module(lib_misc).
   			-export([for/3]).

   			%定义自己的for循环
   			for(Max,Max,F)  ->  [F(Max)]; 
   			for(I,Max,F)    ->  [F(I)|for(I+1,Max,F)].
   		%shell实现
   			1> c(lib_misc).
   			{ok,lib_misc}
   			2> lib_misc:for(1,5, fun(X) -> X end).
   			[1,2,3,4,5]
   			3> 

   	3.实现可重入解析代码、解析组合器或惰性求值器等事物。
   		%返回fun的函数。函数不仅可以使用fun作为参数（例如map和filter),还可以返回fun。
   			1> Fruit = [apple,pear,orange].
   			[apple,pear,orange]
   			2> Maketest = fun(L) -> (fun(X) -> lists:member(X,L) end) end.
   			#Fun<erl_eval.6.52032458>
   			3> IsFruit = Maketest(Fruit).
   			#Fun<erl_eval.6.52032458>
   			4> IsFruit(apple).        
   			true
   			5> IsFruit(hhhh).
   			false
   			6> 
   ```

8. ### if 表达式

   ```erlang
   %条件句式：
   	% if 的格式，Action 执行的结果就是 if 语句的返回值
       if  
         Condition 1 ->  
           Action 1;  
         Condition 2 ->  
           Action 2;  
         Condition 3 ->  
           Action 3;  
         Condition 4 ->  
           Action 4  
         true -> ...   %保护断言，if表达式必须至少有一个关为true，不然会生异常错误。
       end  
   %很多时候，if表达式的最后一个关卡是原子true，确保当其他的关卡都失败时表达式的最后一部分被执行
   ```

9. ### case语句

   ```erlang
   %case的语法：
       case conditional-expression of  
         Pattern1 -> expression1, expression2, .. ;,  
         Pattern2 -> expression1, expression2, .. ;  
         ... ;  
         Patternn -> expression1, expression2, ..  
       end. 

   %示例：
   %% @doc 12.使用case语句和方法匹配二种方式 实现当类型Type为1时对值A／B做加法处理，为2时做减法处理 为3时做乘法处理 为4时做除法处理
   calcul(Type) ->
           case Type of
           {1,A,B}  ->  A + B;

           {2,A,B}  ->  A - B;

           {3,A,B}  ->  A * B;

           {4,A,B}  ->  A / B
   end.
   ```

10. ### 项元比较

   ```erlang
   %% =:= 精确对比   =/= 不

   1> 1=:=1.
   true
   2> 1=:=1.0.
   false
   3> 1=/=1.0.
   true
   4> 1=/=1.
   false
   5> 1=/=2.
   true

   ```

   ### 

