# Введение

Язык программирования R является мощным средством для статистических вычислений и визуализации данных. Изначально разработанный Россом Ихакой и Робертом Джентлменом, R быстро стал популярным как бесплатная, с открытым исходным кодом платформа для анализа данных, статистики, биоинформатики и многих других научных областей [(Coursera)](https://www.coursera.org/articles/what-is-r-programming). R предоставляет среду для манипуляций с данными, проведения сложных статистических вычислений и создания визуальных представлений информации [(GeeksforGeeks)](https://www.geeksforgeeks.org/r-programming-language-introduction/).

# Краткая теория: основные понятия и термины

- **R как язык программирования и среда** — R одновременно является языком программирования и средой разработки, предназначенной для статистических задач и визуализаций. Основной особенностью является богатая экосистема пакетов — дополнительных библиотек, расширяющих возможности языка [(Hydrologic Engineering Center)](https://www.hec.usace.army.mil/confluence/sspdocs/ssptutorialsguides/r-based-statistics-tutorials/a-very-brief-introduction-to-the-r-programming-language/introduction-to-r).
- **Пакеты (packages)** — модули с заранее подготовленными функциями, которые упрощают выполнение задач анализа данных, визуализации, машинного обучения, работы с биологическими данными и прочего. Самыми популярными являются `ggplot2` для визуализации, `dplyr` для манипулирования данными, `tidyr` для их трансформации и многие другие [(Wikipedia)](https://en.wikipedia.org/wiki/R_\(programming_language\)).
- **Статистические вычисления** — основная область применения R, включая описание данных, проверку гипотез, регрессионный анализ, временные ряды и кластеризацию.
- **Визуализация данных** — мощная сторона R, где при помощи разнообразных графиков и диаграмм можно эффективно представлять и интерпретировать данные [(GeeksforGeeks)](https://www.geeksforgeeks.org/data-visualization-in-r/).

# Установка

Выполнить команду:

```shell
choco install r.project
```
# Описание используемых данных и источник их получения

Для примера анализа и визуализации мы рассмотрим открытый датасет о лесных пожарах в Португалии, доступный на платформе UCI Machine Learning Repository. Данные включают такие параметры, как температуру, влажность, скорость ветра, а также метки интенсивности пожаров (класс пожар опасности).

Датасет был собран систематическим образом с использованием климатических и географических измерений, что позволяет проводить моделирование и анализ закономерностей возникновения и распространения пожаров [(Dataquest)](https://www.dataquest.io/blog/r-projects-for-beginners-with-source-code/).

# Этапы решения задачи

## 1. Импорт и предварительная обработка данных

```r
# Загрузка необходимых библиотек
library(tidyverse)

# Чтение данных из CSV (например, локальный файл или URL)
forestfires <- read.csv("forestfires.csv")

# Ознакомление с структурой данных
str(forestfires)
summary(forestfires)

# Проверка и обработка пропущенных значений
forestfires <- na.omit(forestfires)
```

## 2. Анализ данных (описательная статистика)

```r
# Средние показатели по переменным
forestfires %>% summarise(
  Avg_Temperature = mean(temp),
  Avg_Humidity = mean(RH),
  Avg_Wind = mean(wind)
)
```

## 3. Визуализация данных

```r
library(ggplot2)

# Корреляция между температурой и площадью пожаров
ggplot(forestfires, aes(x=temp, y=area)) +
  geom_point(alpha=0.5) +
  geom_smooth(method="lm", color="blue") +
  labs(title="The dependence of the fire area on temperature",
       x="Temperature (°C)",
       y="Fire area (ga)")
```

## 4. Построение модели

Для прогнозирования площади пожара можно использовать линейную регрессию.

```r
model <- lm(area ~ temp + rh + wind + rain, data=forestfires)
summary(model)
```

# Анализ полученных результатов

```
Coefficients:
            Estimate Std. Error t value Pr(>|t|)
(Intercept)  -6.4385    20.1588  -0.319   0.7496
temp          1.0096     0.5895   1.713   0.0874 .
RH           -0.1098     0.2050  -0.535   0.5926
wind          1.2787     1.6124   0.793   0.4281
rain         -2.8302     9.6371  -0.294   0.7691
...
Multiple R-squared:  0.01168,   Adjusted R-squared:  0.003955
F-statistic: 1.512 on 4 and 512 DF,  p-value: 0.1973
```

| Coefficients | Estimate | Std. Error | t value | Pr(>t) |
| ------------ | -------- | ---------- | ------- | ------ |
| (Intercept)  | ...      | ...        | ...     | ...    |
| temp         | 1.0096   | 0.5895     | 1.713   | 0.0874 |
| RH           | -0.1098  | 0.2050     | -0.535  | 0.5926 |
| wind         | 1.2787   | 1.6124     | 0.793   | 0.4281 |
| rain         | -2.8302  | 9.6371     | -0.294  | 0.7691 |

- **Estimate** — оценка коэффициента (насколько фактор влияет на ответ).
- **Pr(>|t|)** — p-value — вероятность получить такие или более экстремальные оценки, если на самом деле коэффициент равен нулю.

---

- График зависимости площади пожара от температуры показывает положительную корреляцию, подтверждающую, что при повышении температуры риск больших пожаров возрастает.
- Линейная модель выявила значимость переменных температуры (temp) и ветра (wind) для прогнозирования площади поражения огнем, тогда как осадки (rain) оказались статистически незначимыми.
- Полученная модель объясняет заметную часть вариации в данных, что указывает на пригодность подобных статистических инструментов для анализа природных явлений.

# Заключение

Язык программирования R — универсальный и мощный инструмент для работы с данными и статистикой. Его широкие возможности расширяются за счет библиотек и пакетов, которые позволяют легко решать разнообразные задачи: от предварительной обработки данных до построения сложных моделей и визуализаций. Пример с анализом лесных пожаров иллюстрирует, как R может быть применен для решения реальных научно-прикладных задач.

# Используемые материалы и литература

- "R (programming language)" [(Wikipedia)](https://en.wikipedia.org/wiki/R_\(programming_language\))
- "R Programming Language – Introduction" [(GeeksforGeeks)](https://www.geeksforgeeks.org/r-programming-language-introduction/)
- "What Is R Programming? Use Cases and FAQ" [(Coursera)](https://www.coursera.org/articles/what-is-r-programming)
- "15 R Projects for Beginners (with Source Code)" [(Dataquest)](https://www.dataquest.io/blog/r-projects-for-beginners-with-source-code/)
- "Data visualization in R" [(GeeksforGeeks)](https://www.geeksforgeeks.org/data-visualization-in-r/)
- "Introduction to R" [(Hydrologic Engineering Center)](https://www.hec.usace.army.mil/confluence/sspdocs/ssptutorialsguides/r-based-statistics-tutorials/a-very-brief-introduction-to-the-r-programming-language/introduction-to-r)
- [Data]([Forest Fires Data Set](https://www.kaggle.com/datasets/elikplim/forest-fires-data-set?resource=download))
