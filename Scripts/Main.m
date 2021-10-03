clear variables 
clc
close all
clf

cd Tomografias;
No_imgs = dir('**/*.dcm');
h = waitbar(0,'leyendo Archivos....');

%Ciclo de carga de pila de imagenes
for i=1 :  size(No_imgs,1)
   I(:,:,i)= dicomread(No_imgs(i).name);
   %figure(1)
   %imshow(I(:,:,i));
   %pause(0.2) %Reproducir con menor velocidad las imagnes
   waitbar(i/size(No_imgs,1)); 
end
close(h); 


%Filtro #1_ contraste R=I*K  K[0,2]
for i=1 :  size(No_imgs,1)
   R(:,:,i) = I(:,:,i)+32765;
   figure(1)
   %imshow(I(:,:,i));
   figure(2)
   %imshow(R(:,:,i));
end

%Filtro #2_Binarizacion
a = [1;4;6;4;1];
b = [1 4 6 4 1];

f_binomial = 1/16*(b*a);

%for i=1 :  size(No_imgs,1)
   T(:,:,1) = convmtx2(double (I(:,:,1)),[a b]); 
   figure(1)
   imshow(I(:,:,1));
   figure(2)
   imshow(T(:,:,1));
%end










