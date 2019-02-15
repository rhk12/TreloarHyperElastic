clear;
a=importdata('Treloar_data.csv');
a(:,1);a(:,2);[m,n]=size(a);
L=0.010; % length in meters
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

figure
subplot(1,2,1)
h=plot(a(:,1),a(:,2));
axis([1 8  0 75]);
set(h,'LineWidth',2);
xlabel('Elongation')
ylabel('Stress')
grid on
grid minor
% 
subplot(1,2,2)
h=plot(engr_strain,stress_pa,ln_strain,stress_pa);
set(h,'LineWidth',2);
axis([0 7  0 7.5e6 ]);
xlabel('Strain')
ylabel('Stress (Pa)')
legend('Engineering ("Nominal") Strain','ln Strain');
grid on
grid minor
hold on


%post-process Abaqus RPT files
plotabaqusportion = 0
if plotabaqusportion == 1
  
    b=importdata('LE-S22.dat');
    b.data
    b.data(:,1)
    b.data(:,2)
    subplot(1,2,2)
    h=plot(b.data(:,1),b.data(:,2));

    c=importdata('NE-S22.dat');
    c.data
    c.data(:,1)
    c.data(:,2)
    subplot(1,2,2)
    h=plot(c.data(:,1),c.data(:,2));
end












