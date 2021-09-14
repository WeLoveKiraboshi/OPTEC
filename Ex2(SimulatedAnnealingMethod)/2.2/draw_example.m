%紅い点の座標(適当な定数)
RED_x=[5 6 7 8 9 10 11 12 13 14 15 16 17 18 19]
RED_z=[1 1.2 1.3 1.4 1.7 1.8 2 2.1 2.3 2.1 1.8 1.7 1.4 1.3 1.2 ]
figure(1);plot(RED_x,RED_z,'ro')
hold on%上書き開始
for ii=1:length(RED_x)-1
    %赤点間の線を結ぶ
    line([RED_x(ii),RED_x(ii+1)],[RED_z(ii),RED_z(ii+1)])
end
hold off%上書き停止
KURO_DAI_x=0;%黒丸大のｘ座標
KURO_DAI_z=10;%黒丸大のz座標
KURO_SHO_x=[5:3:20]%黒丸小のｘ座標
KURO_SHO_z=zeros(1,15)%黒丸小のz座標
hold on%上書き開始
for ii=1:length(KURO_SHO_x)
    %黒丸間の線を結ぶ
    line([KURO_DAI_x,KURO_SHO_x(ii)],[KURO_DAI_z,KURO_SHO_z(ii)],'Color','black')
end
hold off%上書き停止