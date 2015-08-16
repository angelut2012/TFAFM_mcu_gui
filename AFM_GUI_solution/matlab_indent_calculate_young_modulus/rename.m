clear
D=dir
for k=3:length(D)
    if ~D(k).isdir
        continue
    end
    F=dir([D(k).name '\*.txt'])
    for j=1:length(F)
        copyfile([D(k).name '\' F(j).name],[D(k).name '_' F(j).name])
    end
end