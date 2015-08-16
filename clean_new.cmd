robocopy "c:\d" AFM_GUI_solution\AFM_Project\object /MIR

del /q /s AFM_GUI_solution\AFM_Project\object/*
rmdir /q /s AFM_GUI_solution\AFM_Project\object
del /q /s AFM_GUI_solution\bin/*
rmdir /q /s AFM_GUI_solution\bin
pause