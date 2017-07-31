查看内存使用情况：

```erlang
erlang:system_info(process_count).  %%查看进程的数目

erlang:memory().  %%查看内存节点的瓶颈所在的地方

spawn(fun()->etop:start([{output,text},{interval,1},{line,20},{sort,memory}])end).
%% text方式启动etop,其间隔为1秒,输出行数为20行,按照内存排序. 这里spawn一个新进程,目的是输出etop数据时不影响erlang shell 输入.

erlang:process_info(pid(0,57,0)).     %%查看内存占用最高的进程 的状态

% 手动回收
erlang:garbage_collet(pid(0,57,0)).


% 总结：
% 1.服务器编程中，循环一定要用尾递归；
% 2.尽量使用gen_server替换手写loop，就会避免出现内存占用太多的情况

```