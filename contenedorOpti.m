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


-----%Grating-----

theta_i = zeros(Nx);
for i=1:Nx
    if i <= Nx/2
    theta(i) = pi/6 - pi/(3*Nx);
    else
         theta(i) = 0 + pi/(3*Nx);
    end 
    end
    d = 0;
theta_d = theta_i;
beta_a = cos(theta_i)/cos(theta_d); % astigmatism factor