close all;
clear all;

load ("mat0.mat");
%load ("mat1.mat");
%load ("mat2.mat");
%load ("mat3.mat");
%load ("bcsstk27.mat");


eps = 10e-10;

n = length(A);

%verification sym et definie positive
if issymmetric(A) && all(eig(A) > 0)
    disp('La matrice est symétrique et définie positive.');
else
    disp('La matrice n''est pas symétrique et/ou définie positive.');
end

% Génération du vecteur b
b = (1:n)';

fprintf('\n Sans réordonnacement : \n');

% Calcul de la décomposition de Cholesky
L = chol(A, 'lower');

% Résolution du système Ax = b en utilisant la décomposition de Cholesky
x = L' \ (L \ b);

fprintf('nombre de non zeros dans la matrice L est %d \n', nnz(L));

nb_flops = 4*nnz(L);

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

L1 = chol(A1, 'lower');

x = L1' \ (L1 \ b(P));

nb_flops = 4*nnz(L1);

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

L2 = chol(A2, 'lower');

x = L2' \ (L2 \ b(P));

nb_flops = 4*nnz(L2);

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

L3 = chol(A3, 'lower');

x = L3' \ (L3 \ b(P));

nb_flops = 4*nnz(L3);

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

L4 = chol(A4, 'lower');

x = L4' \ (L4 \ b(P));

nb_flops = 4*nnz(L4);

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

L5 = chol(A5, 'lower');

x = L5' \ (L5 \ b(P));

nb_flops = 4*nnz(L5);

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









