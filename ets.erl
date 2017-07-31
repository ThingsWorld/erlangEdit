%% 新建表
ets:new/2 
new(Name, Options) -> tid() | atom()  
%% 类型
Name = atom()            %% name 代表表的名字 
Options = [Option]       %% Options 是一个列表，
Option = 
    Type |               %% ETS 表有四种类型， set | ordered_set | bag | duplicate_bag
    Access |			 %% 访问权限有 public | private | protect
    named_table |        %% 在随后的操作中，不用在确认表
    {keypos, Pos} |		 %% 指定元组中的元素存储 Pos = integer() >= 1
    {heir, Pid :: pid(), HeirData} |      %% heir设置一个进程,继承它
    {heir, none} |
    Tweaks               %%       {write_concurrency, boolean()} 
  						 %%   或者 {read_concurrency, boolean()} 
   						 %%	  或者  compressed（减少内存，但是操作慢）。
%% 表类型描述
set
  % 键值只允许出现一次，不排序
ordered_set
  % 排序，键值不能重复
bag
  % 包表，可以有很多个对象，允许有重复键值，但是两个键值，它的键和值不能一模一样。
duplicate_bag
  % 可以有很多个对象，允许有重复键值，也可以有两个键值，它的键和值一模一样。即{a,1}和{a,1}可以输出。




%% 插入
insert(Tab, ObjectOrObjects) -> true
Tab = tab()				%% 表的名字。
ObjectOrObjects = tuple() | [tuple()]   %% 插入一个对象或者列表到表中。


%% 删除
delete(Tab) -> true  			   %% 删除表中的全部数据
  
delete(Tab, Key) -> true    	   %% 删除表中 key 对应的值，

delete_all_objects(Tab) -> true    %% 在ETS表中删除所有的对象

delete_object(Tab, Object) -> true %% 精确删除表中的元组对象。


%% 查找
look_up(Tab, Key) -> [Object] 	   %% 在一个Tab表中，返回key中的所有列表对象，key在Tab表中查询
lookup_element(Tab, Key, Pos) -> Elem %% 查找Tab表中的key位置的中元素
