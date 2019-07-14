#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/ssh-commands.sh
# Environments:   all
# Purpose:        The collection of steps and sequences required for
#                 executing ssh commands from the jumpbox to the
#                 cluster nodes.
#
# Created on:     23 June 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 23 Jun 2019  | David Sanders               | First release.
# -------------------------------------------------------------------
# 24 Jun 2019  | David Sanders               | Add private registry.
# -------------------------------------------------------------------
# 11 Jul 2019  | David Sanders               | Refactor code and
#              |                             | externalize code into
#              |                             | modules to simplify
#              |                             | understanding and
#              |                             | layout.
# -------------------------------------------------------------------

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh
source /home/${admin}/scripts/do-ssh.sh
source /home/${admin}/scripts/do-ssh-nohup.sh
source /home/${admin}/scripts/do-scp.sh

masters="${masters}"
workers="${workers}"
admin="${admin}"

source /home/${admin}/scripts/ssh-commands/executable-scripts.sh
source /home/${admin}/scripts/ssh-commands/master-commands.sh
source /home/${admin}/scripts/ssh-commands/create-join.sh
source /home/${admin}/scripts/ssh-commands/reboot-masters.sh
source /home/${admin}/scripts/ssh-commands/worker-commands.sh
source /home/${admin}/scripts/ssh-commands/wait-for-workers.sh
source /home/${admin}/scripts/ssh-commands/reboot-workers.sh
source /home/${admin}/scripts/ssh-commands/load-default-apps.sh

banner "ssh-commands.sh" "Completed all commands on all machines"
