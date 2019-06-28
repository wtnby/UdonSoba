echo off
:tempFolderDelete
if exist .\temporary\*.* (
	del /Q .\temporary
	echo 残留ファイル削除完了
)
:InputCheck
set filenum=0
for %%F in (.\input\*.zip) do (set /a filenum=filenum+1)
if not %filenum%==1 (
	echo Error01:inputフォルダにはルームデータのzipファイルを1つだけ入れてください
	goto NGExit
)
echo フォルダ事前チェック完了
:Unzip
.\assets\tools\7za.exe x .\input\*.zip -o.\temporary\
echo 一時フォルダに解凍完了
:DefaultCopy
copy .\assets\images\ .\temporary
echo デフォルト画像コピー完了
:DefineOutputFolder
set time_tmp=%time: =0%
set now=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%
set outputFolder=.\output_%now%
echo %outputFolder%
mkdir %outputFolder%
mkdir %outputFolder%\img
echo 出力フォルダ生成完了
:ChangeExtension
copy .\temporary\*.jpg %outputFolder%\img
ren %outputFolder%\img\*.jpg *.imagedata
copy .\temporary\*.jpeg %outputFolder%\img
ren %outputFolder%\img\*.jpeg *.imagedata
copy .\temporary\*.jpe %outputFolder%\img
ren %outputFolder%\img\*.jpe *.imagedata
echo JPGのコピーと拡張子変更完了
copy .\temporary\*.png %outputFolder%\img
ren %outputFolder%\img\*.png *.imagedata
echo PNGのコピーと拡張子変更完了
copy .\temporary\*.gif %outputFolder%\img
ren %outputFolder%\img\*.gif *.imagedata
echo GIFのコピーと拡張子変更完了
echo ファイルコピーと拡張子変更完了
.\assets\tools\msxsl.exe .\temporary\chat.xml .\assets\xslt\convert.xsl -o %outputFolder%\converted_chatlog.html
echo HTML出力完了
:Deletezipdata
del /Q .\temporary
echo 一時フォルダ内ファイル削除完了
:OKExit
echo 正常終了
pause
exit /b 0
:NGExit
echo 異常終了
pause
exit /b 1

