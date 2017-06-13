%function plot_results()

%close all;
clc;

colors = ['r';'b';'g';'y';'r';'b';'g';'y'];
markers = ['x';'o';'s';'+';'v';'x';'o';'s';'+';'v'];
styles = {'-';':';'-.';'--';'-';':';'-.';'--'};

idx = 1;

G = 0:0.01:2;
S = G.*exp(-2*G);
     
  res_file = sprintf('exp-sendtime4.txt');
  results = load(res_file);
  info = results(1,:);
  tempo = info(1); 
  n_est = info(2);   
  tx_power = info(3);
  
  values = results(2:end,:);

  send_time = values(:,1);
  tams_quadro = values(:,2);
  quadros_colididos = values(:,3);
  quadros_transmitidos = values(:,4); 
  quadros_entregues = quadros_transmitidos-quadros_colididos;
  
  l=10;
  c=6;
  %rate = 60000./reshape(send_time,l,c);
  rate = reshape(send_time,l,c)/1000;
  quadros_ent = reshape(quadros_entregues,l,c);
  quadros_trans = reshape(quadros_transmitidos,l,c);
  

confidence = 95;
mean_result_qe = mean(quadros_ent,1);
std_result_qe = std(quadros_ent,1);
% ci_result_qe = ci(quadros_ent,confidence,1);

mean_result_qt = mean(quadros_trans,1);
std_result_qt = std(quadros_trans,1);
% ci_result_qt = ci(quadros_trans,confidence,1);

mean_result_pr = mean(rate,1);
std_result_pr = std(rate,1);
% ci_result_tq = ci(quadros_trans,confidence,1);

 % figures
  fig1 = figure;
  ax1 = axes('Parent', fig1);
  hold(ax1, 'on');
 
  tam_quadro = tams_quadro(1);
  taxa_bits = tam_quadro/send_time(1);
  %plot(ax1,(quadros_entregues/quadros_colididos)*tam_quadro/tempo/n_est,quadros_entregues*tam_quadro/tempo/n_est,'ro',...
  %'marker',markers(idx),'linewidth',2);
  
  %plot(ax1,G*taxa_bits/n_est,S*taxa_bits/n_est,'linewidth',2);

%   plot(ax1,tams_quadro,(quadros_entregues./quadros_transmitidos),'ro',...
%   'marker',markers(idx),'linewidth',2);

plot(ax1,mean_result_pr,(mean_result_qe./mean_result_qt),'bo',...
  'marker',markers(idx),'linewidth',2);
plot(ax1,mean_result_pr,(mean_result_qe./mean_result_qt),':',...
  'marker',markers(idx),'linewidth',2);
  
  %label_x = 'Packet rate (pkt/min)';
  %label_x = 'Inter-packet interval (sec)';
  label_x = 'Reporting time (sec)';
  the_title = ['Packet delivery ratio vs reporting time (sec), N = ' num2str(n_est) ' nodes'];
  title(ax1,the_title);
  xlabel(ax1,label_x);
  ylabel(ax1,'Packet delivery ratio');
  
  idx = idx+1;
  grid on;
%end


%end