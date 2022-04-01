# Title:    Configuração do Git e do GitHub
# Author:   Viviane Dantas Soares
# File:     Fundamentos da Linguagem R
# Project:  League Online Courses
# Purpose:
Date:       now()


# INSTALL AND LOAD PACKAGES ###################################################

# Load base packages (modo manual) ---------------------------------------------
    # install.packages(" ")
    # library()
    # require()
#------------------------------------------------------------------------------

# Install pacman ("package manager") (instala se necessário; carrega o pacote)-

if (!require("pacman")) install.packages("pacman")

    # pacman must already be installed; then load contributed
    # packages (including pacman) with pacman

pacman::p_load(usethis, magrittr, pacman, rio, tidyverse, lubridate)

#------------------------------------------------------------------------------

# Load base package (usethis)--------------------------------------------------

library (usethis)

# Criar o CAMINHO ABSOLUTO

# create_project("C:/viviane/loc_sgq")

# create_project("C:/home/loc_sgq")

# Saidas no Console-------------------------------------------------------------
    #√ Creating 'C:/home/loc_sgq/'
    # √ Setting active project to 'C:/home/loc_sgq'
    # √ Creating 'R/'
    # √ Writing 'loc_sgq.Rproj'
    # √ Adding '.Rproj.user' to '.gitignore'
    # √ Opening 'C:/home/loc_sgq/' in new RStudio session
    # √ Setting active project to '<no active project>'
    # >

# Configurar o R para o Git e O GitHub #########################################

use_git_config(
    user.name = "vividsoares",
        user.email = "dantas_viviane@hotmail.com"
)

# Ao rodar estes comandos, o R ja casdastra o Git. Isto só se faz uma única vez por máquina.

# Registrar a pasta como repositório -------------------------------------------
# O Git fará a partir de então o controle da pasta desta pasta de versão

use_git()

#   > use_git()

#   Saídas
#   √ Setting active project to 'C:/home/loc_sgq'
#   √ Initialising Git repo
#   √ Adding '.Rhistory', '.Rdata', '.httr-oauth', '.DS_Store' to '.gitignore'
#   There are 3 uncommitted files:
#   * '.gitignore'
#   * 'loc_sgq.R'
#   * 'loc_sgq.Rproj'
#   Is it ok to commit them?

#   1: Absolutely not
#   2: No
#   3: Definitely

#Selection: 3  (as palavras sempre mudam de ordem nas alternativas, e podem ser substituídas por sinônimos)

#-------------------------------------------------------------------------------

#   √ Making a commit with message 'Initial commit'
#   * A restart of RStudio is required to activate the Git pane
#   Restart now?

#   1: Not now
#   2: I agree
#   3: Absolutely not

#   Selection: 2

# CRIAR UM TOKEN ---------------------------------------------------------------

use_git()

create_github_token() # Isto só se faz uma única vez por máquina.

#A função cria o token de acesso pessoal via computador.

gitcreds::gitcreds_set()

# Isto só se faz uma única vez por máquina.
# Esta função pedirá para inserir o token pessoal.

## SAÍDAS no console -------------------------------------------


#   * Call `gitcreds::gitcreds_set()` to register this token in #   the local Git credential store
#   It is also a great idea to store this token in any password
#   -management software that you use
#   √ Opening URL 'https://github.com/settings/tokens/new?scopes#=repo,user,gist,workflow&description=DESCRIBE THE TOKEN\'S USE #CASE'





use_github() # Será usado toda vez que for criar um projeto


gitcreds::gitcreds_set()  # Isto só se faz uma única vez por máquina.

## SAÍDAS no console -------------------------------------------

# -> Your current credentials for 'https://github.com':

#   protocol: https
#   host    : github.com
#   username: PersonalAccessToken
#   password: <-- hidden -->

#   -> What would you like to do?

#   1: Keep these credentials
#   2: Replace these credentials
#   3: See the password / token

#   Selection: 2

#   -> Removing current credentials...

#   ? Enter new password or token: **********************
#   -> Adding new credentials...
#   -> Removing credetials from cache...
#   -> Done.
#   >
