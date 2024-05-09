close all;
clear all;

load ("hydcar20.mat");
%load ("pde225_5e-1.mat");
%load ("piston.mat");


eps = 10e-10;

n = length(A);

%verification sym et definie positive
if issymmetric(A) 
    disp('');
else
    disp('La matrice n''est pas symétrique ');
end

% Génération du vecteur b
b = (1:n)';

fprintf('\n Sans réordonnancement : \n');

% Calcul de la décomposition LU
[L,U,Q] = lu(A);


% Résolution du système Ax = b en utilisant la décomposition de Cholesky
y = L\Q*b;
x=U\y;

fprintf('nombre de non zeros dans la matrice L est %d \n', nnz(L));
fprintf('nombre de non zeros dans la matrice U est %d \n', nnz(U));


nb_flops = 2*nnz(L) + 2*nnz(U);

fprintf('nombre de flops : %d \n',nb_flops);

normwise = ((norm(b-A*x)) / (normest(A)+norm(b)));

if (normwise > eps)
    fprintf('pas de convergence \n')
end

fprintf('normwise : %d \n', normwise);



%% Permutation amd

fprintf('\n Permutation AMD : \n');



P = amd(A);

A1 = A(P,P);

% Calcul de la décomposition LU
[L1,U1,Q1] = lu(A1);


% Résolution du système Ax = b en utilisant la décomposition de Cholesky
y = L1\Q1*b(P);
x=U1\y;

nb_flops = 2*nnz(L1) + 2*nnz(U1);

fprintf('nombre de flops : %d \n',nb_flops);


normwise = (norm(b(P)-A1*x)) / (normest(A1)+norm(b(P)));

if (normwise > eps)
    fprintf('pas de convergence \n')
end

fprintf('normwise : %d \n', normwise);




%% Permutation colamd

fprintf('\n Permutation COLAMD : \n');


P = colamd(A);

A2 = A(P,P);

% Calcul de la décomposition LU
[L2,U2,Q2] = lu(A2);


% Résolution du système Ax = b en utilisant la décomposition de Cholesky
y = L2\(Q2*b(P));
x=U2\y;

nb_flops = 2*nnz(L2) + 2*nnz(U2);

fprintf('nombre de flops : %d \n',nb_flops);

normwise = (norm(b(P)-A2*x)) / (normest(A2)+norm(b(P)));

if (normwise > eps)
    fprintf('pas de convergence \n')
end

fprintf('normwise : %d \n', normwise);


%% Permutation symamd

fprintf('\n Permutation SYMAMD : \n');


P = symamd(A);

A3 = A(P,P);

% Calcul de la décomposition LU
[L3,U3,Q3] = lu(A3);


% Résolution du système Ax = b en utilisant la décomposition de Cholesky
y = L3\(Q3*b(P));
x=U3\y;

nb_flops = 2*nnz(L3) + 2*nnz(U3);

fprintf('nombre de flops : %d \n',nb_flops);

normwise = (norm(b(P)-A3*x)) / (normest(A3)+norm(b(P)));

if (normwise > eps)
    fprintf('pas de convergence \n')
end

fprintf('normwise : %d \n', normwise);


%% Permutation symrcm

fprintf('\n Permutation SYMRCM : \n');


P = colamd(A);

A4 = A(P,P);

% Calcul de la décomposition LU
[L4,U4,Q4] = lu(A4);


% Résolution du système Ax = b en utilisant la décomposition de Cholesky
y = L4\(Q4*b(P));
x=U4\y;

nb_flops = 2*nnz(L4) + 2*nnz(U4);

fprintf('nombre de flops : %d \n',nb_flops);

normwise = (norm(b(P)-A4*x)) / (normest(A4)+norm(b(P)));

if (normwise > eps)
    fprintf('pas de convergence \n')
end

fprintf('normwise : %d \n', normwise);


%% Permutation colperm

fprintf('\n Permutation COLPERM : \n');


P = colamd(A);

A5 = A(P,P);

% Calcul de la décomposition LU
[L5,U5,Q5] = lu(A5);


% Résolution du système Ax = b en utilisant la décomposition de Cholesky
y = L5\(Q5*b(P));
x=U5\y;

nb_flops = 2*nnz(L5) + 2*nnz(U5);

fprintf('nombre de flops : %d \n',nb_flops);

normwise = (norm(b(P)-A5*x)) / (normest(A5)+norm(b(P)));

if (normwise > eps)
    fprintf('pas de convergence \n')
end


fprintf('normwise : %d \n', normwise);




%% affichage de A

subplot(3,3,1)
spy(A)
title('Sans réordonnancement')

subplot(3,3,2)
spy(A1)
title('amd')

subplot(3,3,3)
spy(A2)
title('colamd')

subplot(3,3,4)
spy(A3)
title('symamd')

subplot(3,3,5)
spy(A4)
title('symrcm')

subplot(3,3,6)
spy(A5)
title('colperm')

sgtitle('Affichage de A avant et après permutation')

%% affichage de L
figure(2)

subplot(3,3,1)
spy(L)
title('Sans réordonnancement')

subplot(3,3,2)
spy(L1)
title('amd')

subplot(3,3,3)
spy(L2)
title('colamd')

subplot(3,3,4)
spy(L3)
title('symamd')

subplot(3,3,5)
spy(L4)
title('symrcm')

subplot(3,3,6)
spy(L5)
title('colperm')

sgtitle('Affichage de L avant après permutation')


%% affichage de U
figure(3)

subplot(3,3,1)
spy(U)
title('Sans réordonnancement')

subplot(3,3,2)
spy(U1)
title('amd')

subplot(3,3,3)
spy(U2)
title('colamd')

subplot(3,3,4)
spy(U3)
title('symamd')

subplot(3,3,5)
spy(U4)
title('symrcm')

subplot(3,3,6)
spy(U5)
title('colperm')

sgtitle('Affichage de U avant après permutation')









