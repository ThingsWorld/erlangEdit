%% �½���
ets:new/2 
new(Name, Options) -> tid() | atom()  
%% ����
Name = atom()            %% name ���������� 
Options = [Option]       %% Options ��һ���б�
Option = 
    Type |               %% ETS �����������ͣ� set | ordered_set | bag | duplicate_bag
    Access |			 %% ����Ȩ���� public | private | protect
    named_table |        %% �����Ĳ����У�������ȷ�ϱ�
    {keypos, Pos} |		 %% ָ��Ԫ���е�Ԫ�ش洢 Pos = integer() >= 1
    {heir, Pid :: pid(), HeirData} |      %% heir����һ������,�̳���
    {heir, none} |
    Tweaks               %%       {write_concurrency, boolean()} 
  						 %%   ���� {read_concurrency, boolean()} 
   						 %%	  ����  compressed�������ڴ棬���ǲ���������
%% ����������
set
  % ��ֵֻ�������һ�Σ�������
ordered_set
  % ���򣬼�ֵ�����ظ�
bag
  % ���������кܶ�������������ظ���ֵ������������ֵ�����ļ���ֵ����һģһ����
duplicate_bag
  % �����кܶ�������������ظ���ֵ��Ҳ������������ֵ�����ļ���ֵһģһ������{a,1}��{a,1}���������




%% ����
insert(Tab, ObjectOrObjects) -> true
Tab = tab()				%% ������֡�
ObjectOrObjects = tuple() | [tuple()]   %% ����һ����������б����С�


%% ɾ��
delete(Tab) -> true  			   %% ɾ�����е�ȫ������
  
delete(Tab, Key) -> true    	   %% ɾ������ key ��Ӧ��ֵ��

delete_all_objects(Tab) -> true    %% ��ETS����ɾ�����еĶ���

delete_object(Tab, Object) -> true %% ��ȷɾ�����е�Ԫ�����


%% ����
look_up(Tab, Key) -> [Object] 	   %% ��һ��Tab���У�����key�е������б����key��Tab���в�ѯ
lookup_element(Tab, Key, Pos) -> Elem %% ����Tab���е�keyλ�õ���Ԫ��
