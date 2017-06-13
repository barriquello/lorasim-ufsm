%function plot_results()

%close all;
clc;

colors = ['r';'b';'g';'y';'r';'b';'g';'y'];
markers = ['x';'o';'s';'+';'v';'x';'o';'s';'+';'v'];
styles = {'-';':';'-.';'--';'-';':';'-.';'--'};

idx = 1;

G = 0:0.01:2;
S = G.*exp(-2*G);
     
  res_file = sprintf('exp-payload4.txt');
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

 % figures
  fig1 = figure;
  ax1 = axes('Parent', fig1);
  hold(ax1, 'on');
 
  tam_quadro = tams_quadro(1);
  taxa_bits = tam_quadro/send_time(1);
  %plot(ax1,(quadros_entregues/quadros_colididos)*tam_quadro/tempo/n_est,quadros_entregues*tam_quadro/tempo/n_est,'ro',...
  %'marker',markers(idx),'linewidth',2);
  
  %plot(ax1,G*taxa_bits/n_est,S*taxa_bits/n_est,'linewidth',2);

  plot(ax1,tams_quadro,(quadros_entregues./quadros_transmitidos),'ro',...
  'marker',markers(idx),'linewidth',2);
  
  label_x = 'Payload size (Bytes)';
  the_title = ['Packet delivery ratio (%) vs payload size (Bytes), N = ' num2str(n_est) ' nodes'];
  title(ax1,the_title);
  xlabel(ax1,label_x);
  ylabel(ax1,'Packet delivery ratio (%)');
  
  idx = idx+1;
%end


%end