function point_cluster_cell=trace_couple_index(pufeng_cell,Q,doa_ref)
 %%%应用于情景2 释放升空散射体但未检测到散射体，检测点迹之间的遍历组合   具有散射体索引
 %%%pufeng_cell 是Q个散射体得到的所有可能定位点迹,Q是散射体数量， 过滤掉全0数据，保证输入进来的数据不为0
 %%%pufeng_cell 列数数据行： TDOA时差、等效信噪比_tdoa、FDOA时差、等效信噪比_fdoa
 %%%doa_ref：1*2 参考通道doa数据
 %%%point_cluster_cell是组合定位点迹  元胞矩阵：为了应对不同矩阵数量下不同维矩阵，每个矩阵行数据组合
 %%%行是组合结果：TDOA时差、等效信噪比_tdoa、FDOA时差、等效信噪比_fdoa、方向角_ref，俯仰角_ref 散射体索引
 
 if Q==0
     point_cluster_cell=0;  %%%  保证送进来的散射体都包含有效的数据
 end
 
 if Q==1
     s1_box=pufeng_cell{1};
     shape_s1=size(s1_box);                   %%%得到数据纬度
     point_cluster_cell=cell(1,1);            %%%散射体只有一个 只需创建一个子空间
     point_cluster_cell{1}=zeros(shape_s1(2),7);  
     for i=1:shape_s1(2)
         point_cluster_cell{1}(i,1:4)=(s1_box(1:4,i))';
         point_cluster_cell{1}(i,5:6)=doa_ref;
         point_cluster_cell{1}(i,7)=s1_box(5,i);
     end
 end
 
 if Q==2
    s1_box=pufeng_cell{1};
    shape_s1=size(s1_box);                   %%%得到数据纬度
    s2_box=pufeng_cell{2};
    shape_s2=size(s2_box);                   %%%得到数据纬度
    
    point_cluster_cell=cell(1,2);            %%%散射体两个 两个数据空间
    row_size=shape_s1(2)+shape_s2(2);        %%%散射体行的数量
    point_cluster_cell{1}=zeros(row_size,7); %%%存放散射体单个数据组合空间   增加一个索引位 6->7
    point_cluster_cell{2}=zeros(shape_s1(2)*shape_s2(2),12);  %%%存放两个散射体组合数据空间 增加两个索引位 10 ->12
    
    size_group=[shape_s1(2),shape_s2(2)];
    
    index_1=1;
    %%%%收集M1、M2
    for i=1:2
        si_box=pufeng_cell{i};
        for j=1:size_group(i)
          point_cluster_cell{1}(index_1,1:4)=(si_box(1:4,j))';    %%%提取S1散射体一行
          point_cluster_cell{1}(index_1,5:6)=doa_ref;
          point_cluster_cell{1}(index_1,7)=si_box(5,j);
          index_1=index_1+1;
        end 
    end
     %%%%收集M1/M2
    interlayer_1=1;
       for i=1:shape_s1(2)
          for j=1:shape_s2(2)
           point_cluster_cell{2}(interlayer_1,1:4)=(s1_box(1:4,i))';
           point_cluster_cell{2}(interlayer_1,5:8)=(s2_box(1:4,j))';
           point_cluster_cell{2}(interlayer_1,9:10)=doa_ref;
           point_cluster_cell{2}(interlayer_1,11)=s1_box(5,i);
           point_cluster_cell{2}(interlayer_1,12)=s2_box(5,j);
           interlayer_1=interlayer_1+1; 
          end
       end
         
 end
 
 if Q==3
    s1_box=pufeng_cell{1};
    shape_s1=size(s1_box);                               %%%得到数据纬度
    s2_box=pufeng_cell{2};
    shape_s2=size(s2_box);                               %%%得到数据纬度
    s3_box=pufeng_cell{3};
    shape_s3=size(s3_box);                               %%%得到数据纬度
    
    point_cluster_cell=cell(1,3);                        %%%散射体两个 两个数据空间
    row_size=shape_s1(2)+shape_s2(2)+shape_s3(2);        %%%散射体行的数量
    row_size2=shape_s1(2)*shape_s2(2)+shape_s1(2)*shape_s3(2)+shape_s2(2)*shape_s3(2);
    row_size3=shape_s1(2)*shape_s2(2)*shape_s3(2);
    point_cluster_cell{1}=zeros(row_size,7); %%%存放散射体单个数据组合空间      6 ->7
    point_cluster_cell{2}=zeros(row_size2,12);  %%%存放两个散射体组合数据空间   10->12
    point_cluster_cell{3}=zeros(row_size3,17);  %%% 14 ->17  
    size_group=[shape_s1(2),shape_s2(2),shape_s3(2)];
    
    index_1=1;
    %%%%收集M1、M2、M3
    for i=1:3
        si_box=pufeng_cell{i};
        for j=1:size_group(i)
          point_cluster_cell{1}(index_1,1:4)=(si_box(1:4,j))';    %%%提取S1散射体一行
          point_cluster_cell{1}(index_1,5:6)=doa_ref;
          point_cluster_cell{1}(index_1,7)=si_box(5,j);
          index_1=index_1+1;
        end 
    end
    %%%%收集M1/M2
    interlayer_1=1;
       for i=1:shape_s1(2)
          for j=1:shape_s2(2)
           point_cluster_cell{2}(interlayer_1,1:4)=(s1_box(1:4,i))';
           point_cluster_cell{2}(interlayer_1,5:8)=(s2_box(1:4,j))';
           point_cluster_cell{2}(interlayer_1,9:10)=doa_ref;
           point_cluster_cell{2}(interlayer_1,11)=s1_box(5,i);
           point_cluster_cell{2}(interlayer_1,12)=s2_box(5,j);
           interlayer_1=interlayer_1+1; 
          end
       end
    %%%收集M1/M3
      for i=1:shape_s1(2)
          for j=1:shape_s3(2)
           point_cluster_cell{2}(interlayer_1,1:4)=(s1_box(1:4,i))';
           point_cluster_cell{2}(interlayer_1,5:8)=(s3_box(1:4,j))';
           point_cluster_cell{2}(interlayer_1,9:10)=doa_ref;
           point_cluster_cell{2}(interlayer_1,11)=s1_box(5,i);
           point_cluster_cell{2}(interlayer_1,12)=s3_box(5,j);
           interlayer_1=interlayer_1+1; 
          end
      end
        %%%收集M2/M3
      for i=1:shape_s2(2)
          for j=1:shape_s3(2)
           point_cluster_cell{2}(interlayer_1,1:4)=(s2_box(1:4,i))';
           point_cluster_cell{2}(interlayer_1,5:8)=(s3_box(1:4,j))';
           point_cluster_cell{2}(interlayer_1,9:10)=doa_ref;
           point_cluster_cell{2}(interlayer_1,11)=s2_box(5,i);
           point_cluster_cell{2}(interlayer_1,12)=s3_box(5,j);
           interlayer_1=interlayer_1+1; 
          end
      end
      %%%%收集M1/M2/M3
      interlayer_2=1;
      for i=1:shape_s1(2)
          for j=1:shape_s2(2)
              for k=1:shape_s3(2)
               point_cluster_cell{3}(interlayer_2,1:4)=(s1_box(1:4,i))';
               point_cluster_cell{3}(interlayer_2,5:8)=(s2_box(1:4,j))';
               point_cluster_cell{3}(interlayer_2,9:12)=(s3_box(1:4,k))';
               point_cluster_cell{3}(interlayer_2,13:14)=doa_ref;
               point_cluster_cell{3}(interlayer_2,15)=s1_box(5,i);
               point_cluster_cell{3}(interlayer_2,16)=s2_box(5,j);
               point_cluster_cell{3}(interlayer_2,17)=s3_box(5,k);
               interlayer_2=interlayer_2+1;
              end
          end
      end  
 end
 
 if Q==4
    s1_box=pufeng_cell{1};
    shape_s1=size(s1_box);                               %%%得到数据纬度
    s2_box=pufeng_cell{2};
    shape_s2=size(s2_box);                               %%%得到数据纬度
    s3_box=pufeng_cell{3};
    shape_s3=size(s3_box);                               %%%得到数据纬度
    s4_box=pufeng_cell{4};
    shape_s4=size(s4_box);                               %%%得到数据纬度
    
    point_cluster_cell=cell(1,4);                        %%%散射体两个 两个数据空间
    row_size=shape_s1(2)+shape_s2(2)+shape_s3(2)+shape_s4(2);        %%%散射体行的数量
    row_size2=shape_s1(2)*shape_s2(2)+shape_s1(2)*shape_s3(2)+shape_s2(2)*shape_s3(2)+shape_s1(2)*shape_s4(2)+shape_s2(2)*shape_s4(2)+shape_s3(2)*shape_s4(2);
    row_size3=shape_s1(2)*shape_s2(2)*shape_s3(2)+shape_s1(2)*shape_s2(2)*shape_s4(2)+shape_s2(2)*shape_s3(2)*shape_s4(2);
    row_size4=shape_s1(2)*shape_s2(2)*shape_s3(2)*shape_s4(2);
    point_cluster_cell{1}=zeros(row_size,7); %%%存放散射体单个数据组合空间    6-》7
    point_cluster_cell{2}=zeros(row_size2,12);  %%%存放两个散射体组合数据空间 10》12
    point_cluster_cell{3}=zeros(row_size3,17);  %%%%     14 -》17
    point_cluster_cell{4}=zeros(row_size4,18);  %%%4个散射体不需要索引
    size_group=[shape_s1(2),shape_s2(2),shape_s3(2),shape_s4(2)];
    
    index_1=1;
    %%%%收集M1、M2、M3、M4
    for i=1:4
        si_box=pufeng_cell{i};
        for j=1:size_group(i)
          point_cluster_cell{1}(index_1,1:4)=(si_box(1:4,j))';    %%%提取S1散射体一行
          point_cluster_cell{1}(index_1,5:6)=doa_ref;
          point_cluster_cell{1}(index_1,7)=si_box(5,j);
          index_1=index_1+1;
        end 
    end
    %%%%收集M1/M2
    interlayer_1=1;
       for i=1:shape_s1(2)
          for j=1:shape_s2(2)
           point_cluster_cell{2}(interlayer_1,1:4)=(s1_box(1:4,i))';
           point_cluster_cell{2}(interlayer_1,5:8)=(s2_box(1:4,j))';
           point_cluster_cell{2}(interlayer_1,9:10)=doa_ref;
            point_cluster_cell{2}(interlayer_1,11)=s1_box(5,i);
           point_cluster_cell{2}(interlayer_1,12)=s2_box(5,j);
           interlayer_1=interlayer_1+1; 
          end
       end
    %%%收集M1/M3
      for i=1:shape_s1(2)
          for j=1:shape_s3(2)
           point_cluster_cell{2}(interlayer_1,1:4)=(s1_box(1:4,i))';
           point_cluster_cell{2}(interlayer_1,5:8)=(s3_box(1:4,j))';
           point_cluster_cell{2}(interlayer_1,9:10)=doa_ref;
           point_cluster_cell{2}(interlayer_1,11)=s1_box(5,i);
           point_cluster_cell{2}(interlayer_1,12)=s3_box(5,j);
           interlayer_1=interlayer_1+1; 
          end
      end
        %%%收集M2/M3
      for i=1:shape_s2(2)
          for j=1:shape_s3(2)
           point_cluster_cell{2}(interlayer_1,1:4)=(s2_box(1:4,i))';
           point_cluster_cell{2}(interlayer_1,5:8)=(s3_box(1:4,j))';
           point_cluster_cell{2}(interlayer_1,9:10)=doa_ref;
            point_cluster_cell{2}(interlayer_1,11)=s2_box(5,i);
           point_cluster_cell{2}(interlayer_1,12)=s3_box(5,j);
           interlayer_1=interlayer_1+1; 
          end
      end
       %%%收集M1/M4
      for i=1:shape_s1(2)
          for j=1:shape_s4(2)
           point_cluster_cell{2}(interlayer_1,1:4)=(s1_box(1:4,i))';
           point_cluster_cell{2}(interlayer_1,5:8)=(s4_box(1:4,j))';
           point_cluster_cell{2}(interlayer_1,9:10)=doa_ref;
           point_cluster_cell{2}(interlayer_1,11)=s1_box(5,i);
           point_cluster_cell{2}(interlayer_1,12)=s4_box(5,j);
           interlayer_1=interlayer_1+1; 
          end
      end
      %%%%%收集M2/M4
      for i=1:shape_s2(2)
          for j=1:shape_s4(2)
           point_cluster_cell{2}(interlayer_1,1:4)=(s2_box(1:4,i))';
           point_cluster_cell{2}(interlayer_1,5:8)=(s4_box(1:4,j))';
           point_cluster_cell{2}(interlayer_1,9:10)=doa_ref;
           point_cluster_cell{2}(interlayer_1,11)=s2_box(5,i);
           point_cluster_cell{2}(interlayer_1,12)=s4_box(5,j);
           interlayer_1=interlayer_1+1; 
          end
      end
      %%%%%收集M3/M4
      for i=1:shape_s3(2)
          for j=1:shape_s4(2)
           point_cluster_cell{2}(interlayer_1,1:4)=(s3_box(1:4,i))';
           point_cluster_cell{2}(interlayer_1,5:8)=(s4_box(1:4,j))';
           point_cluster_cell{2}(interlayer_1,9:10)=doa_ref;
           point_cluster_cell{2}(interlayer_1,11)=s3_box(5,i);
           point_cluster_cell{2}(interlayer_1,12)=s4_box(5,j);
           interlayer_1=interlayer_1+1; 
          end
      end
      
      %%%%收集M1/M2/M3
      interlayer_2=1;
      for i=1:shape_s1(2)
          for j=1:shape_s2(2)
              for k=1:shape_s3(2)
               point_cluster_cell{3}(interlayer_2,1:4)=(s1_box(1:4,i))';
               point_cluster_cell{3}(interlayer_2,5:8)=(s2_box(1:4,j))';
               point_cluster_cell{3}(interlayer_2,9:12)=(s3_box(1:4,k))';
               point_cluster_cell{3}(interlayer_2,13:14)=doa_ref;
               point_cluster_cell{3}(interlayer_2,15)=s1_box(5,i);
               point_cluster_cell{3}(interlayer_2,16)=s2_box(5,j);
               point_cluster_cell{3}(interlayer_2,17)=s3_box(5,k);
               interlayer_2=interlayer_2+1;
              end
          end
      end  
     %%%收集M1/M2/M4
      for i=1:shape_s1(2)
          for j=1:shape_s2(2)
              for k=1:shape_s4(2)
               point_cluster_cell{3}(interlayer_2,1:4)=(s1_box(1:4,i))';
               point_cluster_cell{3}(interlayer_2,5:8)=(s2_box(1:4,j))';
               point_cluster_cell{3}(interlayer_2,9:12)=(s4_box(1:4,k))';
               point_cluster_cell{3}(interlayer_2,13:14)=doa_ref;
               point_cluster_cell{3}(interlayer_2,15)=s1_box(5,i);
               point_cluster_cell{3}(interlayer_2,16)=s2_box(5,j);
               point_cluster_cell{3}(interlayer_2,17)=s4_box(5,k);
               interlayer_2=interlayer_2+1;
              end
          end
      end
     %%%收集M2/M3/M4
      for i=1:shape_s2(2)
          for j=1:shape_s3(2)
              for k=1:shape_s4(2)
               point_cluster_cell{3}(interlayer_2,1:4)=(s2_box(1:4,i))';
               point_cluster_cell{3}(interlayer_2,5:8)=(s3_box(1:4,j))';
               point_cluster_cell{3}(interlayer_2,9:12)=(s4_box(1:4,k))';
               point_cluster_cell{3}(interlayer_2,13:14)=doa_ref;
               point_cluster_cell{3}(interlayer_2,15)=s2_box(5,i);
               point_cluster_cell{3}(interlayer_2,16)=s3_box(5,j);
               point_cluster_cell{3}(interlayer_2,17)=s4_box(5,k);
               interlayer_2=interlayer_2+1;
              end
          end
      end
    
      %%%收集M1/M2/M3/M4
      interlayer_3=1;
      for i=1:shape_s1(2)
          for j=1:shape_s2(2)
              for k=1:shape_s3(2)
                  for d=1:shape_s4(2)
                      point_cluster_cell{4}(interlayer_3,1:4)=(s1_box(1:4,i))';
                      point_cluster_cell{4}(interlayer_3,5:8)=(s2_box(1:4,j))';
                      point_cluster_cell{4}(interlayer_3,9:12)=(s3_box(1:4,k))';
                      point_cluster_cell{4}(interlayer_3,13:16)=(s4_box(1:4,d))';
                      point_cluster_cell{4}(interlayer_3,17:18)=doa_ref;
                      interlayer_3=interlayer_3+1;
                  end
              end
          end
      end
 end