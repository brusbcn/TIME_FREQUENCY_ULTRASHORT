function power = ObtainPower(specA,lambda)
fprintf(specA, 'PWR lambda');
fprintf(specA, 'PWR?');
fprintf(specA,'PWRR?');
power = fscanf(specA);
end

fprintf(specA, 'ANA ENV, r');
fprintf(specA, 'ANA?');
disp(fscanf(specA));
