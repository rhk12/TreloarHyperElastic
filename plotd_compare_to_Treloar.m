clear;
a=importdata('Treloar_data.csv');
a(:,1);a(:,2);[m,n]=size(a);
L = 0.010;  % length in meters
T = 0.0008; % thickness in meters 
W = 0.003;  % width in meters

current_length=a(:,1)*L;
engr_strain=(current_length-L)/L;
ln_strain=log(current_length/L);
format shortEng
% need to convert kg/cm^2 to Pascals
stress_pa=a(:,2)*100*100*9.80665;
% write out text file that can be opened in 
% abaqus to define material property data
fID=fopen('Treloar_data_abaqus_format.dat','w');
for i=1:m
   % fprintf(fID,'%e   %e\n',stress_pa(i),ln_strain(i));
    fprintf(fID,'%e   %e\n',stress_pa(i),engr_strain(i));
end
fclose(fID);

% plot original data from Treloar
figure
subplot(1,2,1)
h=plot(a(:,1),a(:,2)); 
set(h,'LineWidth',2);
xlabel('Elongation (Extension ratio)')
ylabel('Tension (kg/cm^2)')
hold on 
grid on
grid minor


%post-process Abaqus RPT files
plotabaqusportion = 1;
if plotabaqusportion == 1
  
   
     d=importdata('disp.dat');
     deformed_y= str2double(d.textdata(3:end,2));
     elongation=(L+deformed_y) ./ L;


     rf=importdata('rf.dat')
     rf_y=rf.data(:,2)
     nominal_stress=-2.0*rf_y ./ (W * T );
     subplot(1,2,1)
     h=plot(elongation,nominal_stress/(100*100*9.80665));

end












