# bir_tracking-project

This repository creates a graph for project tracking. 

**Keywords**: Project, Follow-up

**Author**: [Mateus Seixas](https://github.com/seixasxbr), [Anderson Lima](https://github.com/aldenpower)

**Affiliation**: [BIR - Brazilian Institute of Robotics](https://github.comBrazilian-Institute-of-Robotics) <br />
**Maintainer**: [Mateus Seixas](https://github.com/seixasxbr), [Anderson Lima](https://github.com/aldenpower)

_For more details visit_ [RASC](https://www.braziliansinrobotics.com/)

## Installation on Visual Studio Code

1. Install R extension on VS code

![graph](./resources/extension.png)

> _After the installation confirm the installation of the r language server_

2. Open the R extension menu and install the packages listed below

![graph](./resources/install.png)

- ggplot2
- config
- tikzDevice


3. Now clone this repository

```bash
git clone https://github.com/Brazilian-Institute-of-Robotics/bir_tracking-project.git
```
***
4. Enter in the repository directory

_Now you can edit the config.yml file for your needs or simple run as default configuration_


***

5. Run the script **acompanhamento.R** at the terminal

```bash
Rscript acompanhamento.R
```

> At the resources folder there is the LaTex figure **graph.text** code generated and the **graph.png** figure


_The graph generated_

![graph](./resources/graph.png)


