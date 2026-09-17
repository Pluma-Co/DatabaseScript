# DatabaseScript

📌 Guia Rápido dos Repositórios e Git
📂 Organização dos Repositórios
🗄️ database: Scripts SQL, migrations e modelagem.

💻 app: Código-fonte do Backend e Frontend.

⚠️ Regras Principais
🔒 Sem commits na main: Trabalhe sempre na sua própria branch.

❌ NUNCA use git add .: Adicione apenas os arquivos que realmente quer enviar.

📝 Rascunhos ficam na sua branch: Suba para a main apenas o código necessário e funcional.

🏷️ Padrão de Commits
Utilize obrigatoriamente os prefixos abaixo no início da mensagem do commit:

feat: Para criação de novas funcionalidades ou arquivos.

Exemplo: git commit -m "feat: adiciona rota de usuarios"

fix: Para correção de erros ou bugs.

Exemplo: git commit -m "fix: corrige conexao com o banco"

🚀 Passo a Passo
1. Verifique onde você está e crie sua branch
Bash
# Conferir em qual branch você está no momento
git branch

# Ir para a main e atualizar
git checkout main
git pull origin main

# Criar e mudar para a sua nova branch
git checkout -b nome-da-sua-branch
2. Adicione APENAS os arquivos específicos
Bash
# ❌ EVITE: git add .

# ✅ USE: git add especificando o arquivo
git add src/controllers/user.js
git add src/views/login.html
3. Salve com o padrão de commit e envie
Bash
# Se for uma criação/funcionalidade nova:
git commit -m "feat: cria tela de cadastro"

# Se for a correção de um erro:
git commit -m "fix: corrige erro no botao de salvar"

# Enviar para o GitHub
git push origin nome-da-sua-branch
4. Abra um Pull Request (PR) no GitHub direcionado à branch main.
