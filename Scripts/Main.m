clear variables 
clc
close all
clf

cd Tomografias;
No_imgs = dir('**/*.dcm');
h = waitbar(0,'leyendo Archivos....');

%Ciclo de carga de pila de imagenes
for i=1 :  size(No_imgs,1)
   I(:,:,i)= dicomread(No_imgs(i).name); %I(m,n,#imagen)
   figure(1)
   imshow(I(:,:,i),[]);
    pause(0.2) %Reproducir con menor velocidad las imagnes
   waitbar(i/size(No_imgs,1)); 
end
close(h); 


%Filtro #1_ contraste R=I*K  K[0,2]

%{
 and for i=1 :  size(No_imgs,1)
   R(:,:,i) = I(:,:,i)+32765;
   figure(1)
   imshow(I(:,:,i));
   figure(2)
   imshow(R(:,:,i));
   end
 %}

%Filtro #2_Binomial
a = [1;4;6;4;1]/16;
b = [1 4 6 4 1]/16;
%f_binomial = 1/16*(b*a);

%Conevtir las imagenes a double
%{
Idouble = double(I);
T = Idouble*0;
Bin = [1 4 6 4 1; 4 16 24 16 4; 6 24 36 24 6; 4 16 24 16 4;1 4 6 4 1]/16;


%for i=1 :  size(No_imgs,1)
   T = conv2(Bin,I); 
   figure(1) 
   imshow(I);
   figure(2)
   imshow(T);
%end
%}









