:setEnvironment
echo off
setlocal enabledelayedexpansion
echo ���ϐ��̐ݒ芮��
:tempFolderDelete
if exist .\temporary\*.* (
	del /Q .\temporary
	echo �c���t�@�C���폜����
)
:InputCheck
set filenum=0
for %%F in (.\input\*.zip) do (set /a filenum=filenum+1)
if not %filenum%==1 (
	echo Error01:input�t�H���_�ɂ̓��[���f�[�^��zip�t�@�C����1��������Ă�������
	goto NGExit
)
echo �t�H���_���O�`�F�b�N����
:LoadChatTabConfig
set n=-1
for /f %%a in (.\input\chat-tab.txt) do (
	set /A n=n+1
	set tabname[!n!]=%%a
)
set /a tabnum=n+1
echo �^�u��=%tabnum%
for /l %%b in (0,1,%n%) do ( echo !tabname[%%b]!)
echo �`���b�g�^�u�o�͐ݒ�ǂݍ��݊���
:Unzip
.\assets\tools\7za.exe x .\input\*.zip -o.\temporary\
echo �ꎞ�t�H���_�ɉ𓀊���
:DefaultCopy
copy .\assets\images\ .\temporary
echo �f�t�H���g�摜�R�s�[����
:DefineOutputFolder
set time_tmp=%time: =0%
set now=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%
set outputFolder=.\output_%now%
echo %outputFolder%
mkdir %outputFolder%
mkdir %outputFolder%\img
echo �o�̓t�H���_��������
:ChangeExtension
copy .\temporary\*.jpg %outputFolder%\img
ren %outputFolder%\img\*.jpg *.imagedata
copy .\temporary\*.jpeg %outputFolder%\img
ren %outputFolder%\img\*.jpeg *.imagedata
copy .\temporary\*.jpe %outputFolder%\img
ren %outputFolder%\img\*.jpe *.imagedata
echo JPG�̃R�s�[�Ɗg���q�ύX����
copy .\temporary\*.png %outputFolder%\img
ren %outputFolder%\img\*.png *.imagedata
echo PNG�̃R�s�[�Ɗg���q�ύX����
copy .\temporary\*.gif %outputFolder%\img
ren %outputFolder%\img\*.gif *.imagedata
echo GIF�̃R�s�[�Ɗg���q�ύX����
echo �t�@�C���R�s�[�Ɗg���q�ύX����
:convert_main
for /l %%c in (0,1,%n%) do (
	.\assets\tools\msxsl.exe .\temporary\chat.xml .\assets\xslt\convert.xsl tabname=!tabname[%%c]! -o %outputFolder%\converted_chatlog_!tabname[%%c]!.html 
)
.\assets\tools\msxsl.exe .\temporary\chat.xml .\assets\xslt\convert.xsl -o %outputFolder%\converted_chatlog.html 
echo HTML�o�͊���
:Deletezipdata
del /Q .\temporary
echo �ꎞ�t�H���_���t�@�C���폜����
:OKExit
echo ����I��
pause
exit /b 0
:NGExit
echo �ُ�I��
pause
exit /b 1
