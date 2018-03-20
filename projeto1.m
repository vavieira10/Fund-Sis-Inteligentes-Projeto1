%% Projeto 1 de FCS 1/2018
% Alvaro Torres Vieira - 14/0
% Victor Araujo Vieira - 14/0032801

%% Carregando o dataset fisher iris e inicializando as variaveis
load fisheriris;
medidas = meas;
respostas = species;

proporcaoTreino = 0.7; % proporcao da amostra que sera usada para treino
numAmostras = size(species, 1);
numCadaClasse = numAmostras/3;

% Numero de amostras pra treino
nTreino = numAmostras*proporcaoTreino;

% Criacao das variaveis que serao usadas para gravar os dados de treino e
% teste
medidasTreino = zeros(nTreino, size(medidas, 2));
medidasTeste = zeros(numAmostras - nTreino, size(medidas, 2));

% Quantidade de cada classe que vao ser usadas para treino e teste
numPorClasseTreino = numCadaClasse*proporcaoTreino;
numPorClasseTeste = numCadaClasse - numPorClasseTreino;

% Construindo as variaveis de treinamento e teste

% primeira classe
medidasTreino(1:numPorClasseTreino, :) = medidas(1:numPorClasseTreino, :);
medidasTeste(1:numPorClasseTeste, :) = medidas(numPorClasseTreino + 1 : numCadaClasse, :);
respostasTreino(1:numPorClasseTreino, :) = respostas(1:numPorClasseTreino, :);
respostasTeste(1:numPorClasseTeste, :) = respostas(numPorClasseTreino + 1 : numCadaClasse, :);

% segunda classe
medidasTreino(numPorClasseTreino + 1 : numPorClasseTreino*2, :) = medidas(numCadaClasse + 1 : numCadaClasse + numPorClasseTreino, :);
medidasTeste(numPorClasseTeste + 1 : numPorClasseTeste*2, :) = medidas(numCadaClasse + numPorClasseTreino + 1 : numCadaClasse*2, :);
respostasTreino(numPorClasseTreino + 1 : numPorClasseTreino*2, :) = respostas(numCadaClasse + 1 : numCadaClasse + numPorClasseTreino, :);
respostasTeste(numPorClasseTeste + 1 : numPorClasseTeste*2, :) = respostas(numCadaClasse + numPorClasseTreino + 1 : numCadaClasse*2, :);

% terceira classe
medidasTreino(numPorClasseTreino*2 + 1 : numPorClasseTreino*3, :) = medidas(numCadaClasse*2 + 1 : numCadaClasse*2 + numPorClasseTreino, :);
medidasTeste(numPorClasseTeste*2 + 1 : numPorClasseTeste*3, :) = medidas(numCadaClasse*2 + numPorClasseTreino + 1 : numCadaClasse*3, :);
respostasTreino(numPorClasseTreino*2 + 1 : numPorClasseTreino*3, :) = respostas(numCadaClasse*2 + 1 : numCadaClasse*2 + numPorClasseTreino, :);
respostasTeste(numPorClasseTeste*2 + 1 : numPorClasseTeste*3, :) = respostas(numCadaClasse*2 + numPorClasseTreino + 1 : numCadaClasse*3, :);


%% Criando os modelos para o treinamento usando o metodo Knn
% O standardize eh para padronizar as escalas, de forma a nao atrapalhar no
% treinamento e consequentemente na predicao

% Treinamento com K = 1
modeloK1 = fitcknn(medidasTreino, respostasTreino, 'NumNeighbors', 1, 'Standardize',1);
% Predicao com K = 1
respostaK1 = predict(modeloK1, medidasTeste);

% Treinamento com K = 5
modeloK5 = fitcknn(medidasTreino, respostasTreino, 'NumNeighbors', 5, 'Standardize',1);
% Predicao com K = 5
respostaK5 = predict(modeloK5, medidasTeste);

% Treinamento com K = 10
modeloK10 = fitcknn(medidasTreino, respostasTreino, 'NumNeighbors', 10, 'Standardize',1);
% Predicao com K = 10
respostaK10 = predict(modeloK10, medidasTeste);

% Treinamento com K = 30
modeloK30 = fitcknn(medidasTreino, respostasTreino, 'NumNeighbors', 30, 'Standardize',1);
% Predicao com K = 30
respostaK30 = predict(modeloK30, medidasTeste);

% Treinamento com K = 50
modeloK50 = fitcknn(medidasTreino, respostasTreino, 'NumNeighbors', 50, 'Standardize',1);
% Predicao com K = 50
respostaK50 = predict(modeloK50, medidasTeste);

%% Gerando e imprimindo as matrizes de confusao para cada K usado para treinar o Knn

%K = 1
geraMatConf(respostasTeste, respostaK1, medidasTeste);

%K = 5
geraMatConf(respostasTeste, respostaK5, medidasTeste);

%K = 10
geraMatConf(respostasTeste, respostaK10, medidasTeste);

%K = 30
geraMatConf(respostasTeste, respostaK30, medidasTeste);

%K = 50
geraMatConf(respostasTeste, respostaK50, medidasTeste);

