function power = ObtainPower(specA,lambda)
fprintf(specA, 'PWR lambda');
fprintf(specA, 'PWR?');
fprintf(specA,'PWRR?');
power = fscanf(specA);
end

fprintf(specA, 'ANA ENV, r');
fprintf(specA, 'ANA?');
disp(fscanf(specA));

C = textscan(fid,'%s%s%[^\n]');
fclose(fid);
C = [C{:}];
% Convert to numeric:
F = cellfun(@(s)sscanf(s,'%f,').',C(:,3),'UniformOutput',false);
X = ~cellfun('isempty',F);
str = C(X,1:2);
num = F(X);