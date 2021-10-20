

I = dicomread('1-113.dcm');

%I = imread('Pinguinos.jpg');
Idouble = double(I(:,:,1));
Imax = max(max(Idouble))
s = size(I);

%%Prueba de contraste
C = Idouble* 2;

%%Pruebas convolucion con filtros binomial
Sua = [1 2 1; 2 4 2; 1 2 1]/16;
Bin5x5 = [1 4 6 4 1; 4 16 24 16 4; 6 24 36 24 6; 4 16 24 16 4; 1 4 6 4 1]/256;
p = imread('cameraman.tif');
BconvBin = conv2(Bin5x5,C);
sizeB = size(BconvBin);
M = uint16(BconvBin(3:sizeB(1)-2,3:sizeB(2)-2));

H = imhist(M,65536);
%stem(H);

%%BconvSua = conv2(Sua,BconvBin); 
%%kernel = [1 1 1; 1 1 1; 1 1 1]/9; 

%%pasaAltos = Idouble - BconvSua;
  
%Convolucion manual
%{
for i = 3:s(1)-2
    for j=3:s(2)-2
        ventana = C(i-2:i+2,j-2:j+2);
        prod = ventana .* Bin;
        pix = sum(sum(prod));
        B(i,j) = pix;
    end    
end
%}

%Binarizacion nos ayuda a quitar defectos de la foto como el objeto en el
%que se postra la cabeza


T=zeros(size(BconvBin));

U = uint16(otsuthresh(H)*65536);

for i = 1: sizeB(1)
    for j=1: sizeB(2)
        if BconvBin(i,j,1) < 3000
            T(i,j,1) = 0;
        else
            T(i,j,1) = 255;
        end    
    end
end

max(max(BconvBin))

figure(1),subplot(2,2,1),imshow(uint16(Idouble),[]),title('Imagen original') 
figure(1),subplot(2,2,2),imshow(uint16(BconvBin),[]),title('Imagen binomial 5x5')
figure(1),subplot(2,2,3),imshow(uint8(T)),title('Imagen binarizacion')
imtool(I);

    
   
