function findreplaceFile(file,findStr,replaceStr)

tempFile = ['tmp' datestr(clock,30) '_' file];
fidOut = fopen(tempFile,'w');
fidIn = fopen(file,'r');
while ~feof(fidIn)
   s = fgetl(fidIn);
   s = regexprep(s,findStr,replaceStr);
   fprintf(fidOut,'%s\n',s);
%    disp(s)
end 

fclose(fidIn);
fclose(fidOut);
copyfile(tempFile,file)

delete(tempFile)