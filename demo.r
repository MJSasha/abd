# Загрузка необходимых библиотек
library(tidyverse)

# Чтение данных из CSV (например, локальный файл или URL)
forestfires <- read.csv("forestfires.csv")

# Ознакомление с структурой данных
str(forestfires)
summary(forestfires)

# Проверка и обработка пропущенных значений
forestfires <- na.omit(forestfires)

# Средние показатели по переменным
forestfires %>% summarise(
  Avg_Temperature = mean(temp),
  Avg_Humidity = mean(RH),
  Avg_Wind = mean(wind)
)

library(ggplot2)

# Корреляция между температурой и площадью пожаров
ggplot(forestfires, aes(x=temp, y=area)) +
  geom_point(alpha=0.5) +
  geom_smooth(method="lm", color="blue") +
  labs(title="The dependence of the fire area on temperature",
       x="Temperature (°C)",
       y="Fire area (ga)")

model <- lm(area ~ temp + RH + wind + rain, data=forestfires)
summary(model)
