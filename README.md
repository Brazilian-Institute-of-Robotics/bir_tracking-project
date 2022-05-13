# bir_tracking-project

This repository creates a graph for project tracking. 

**Keywords**: Project, Follow-up

**Author**: [Mateus Seixas](https://github.com/seixasxbr), [Anderson Lima](https://github.com/aldenpower)

**Affiliation**: [BIR - Brazilian Institute of Robotics](https://github.comBrazilian-Institute-of-Robotics) <br />
**Maintainer**: [Mateus Seixas](https://github.com/seixasxbr), [Anderson Lima](https://github.com/aldenpower)

_For more details visit_ [RASC](https://www.braziliansinrobotics.com/)

## Installation on Visual Studio Code

1. Install R extension on VS code

![graph](./source/extension.png)

> _After the installation confirm the installation of the r language server_

2. Open the R extension menu and install the packages listed below

![graph](./source/install.png)

- ggplot2
- config
- tikzDevice


3. Now clone this repository

```bash
git clone https://github.com/Brazilian-Institute-of-Robotics/bir_tracking-project.git
```
***
4. Enter in the repository directory

_Now you can edit the **config.yml** file for your needs, create as many configuration files as you need, or simple run as default configuration_

> If you create more configuration files, keep the name pattern (config2.yml, config3.yml ... confign.yml), the program will catch the last config file

![graph](./source/config.png)

***

5. Run the script **acompanhamento.R** at the terminal

```bash
Rscript acompanhamento.R
```

> At the output folder there is the LaTex figure **graph.text** code generated, **graph.png** figure and a **Rplots.pdf** pdf file


_You can see an example of the graph generated below_

![graph](./source/graph.png)
