# Figure 6: Average Labor Shortage Rate by Cluster (2009~2023)

library(ggplot2)
library(haven)
library(tidyverse)
library(cluster)
library(factoextra)

lbs<- read_dta("lbs_average_1.dta")

lbs_c <- read_dta("lbs_cluster.dta")
lbs_t <- read_dta("lbs_average_tot.dta")

ggplot(lbs_c, aes(x = year, y = lbs_average,  color = factor(cluster, levels = c(2, 4, 1, 3)))) +
  geom_line(alpha = 1, size = 1, linetype = "dashed") +
  geom_line(data = subset(lbs_t, industry == 0), aes(x = year, y = lbs_average), 
            color = "black", alpha = 1, size = 1.5) +
  labs(x = "Year", y = "Average in Labor Shortage Rate (%)") +
  theme_minimal()+
  scale_color_manual(
    name = "Cluster", 
    values = c("#4169E1", "#009900" ,"#FF4500", "#AA0011"),
    labels = c("1", "2", "3", "4")) +
  theme(legend.position = "top",
        legend.background = element_rect(color = "black", fill = "white"),
        legend.box.margin = margin(1, 1, 1, 1),
        legend.spacing.x = unit(2, "pt"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        plot.margin = margin(0.2, 0.2, 0.2, 0.2, "cm"),
        axis.title.y = element_text(margin = margin(r = 10)),
        axis.text.y = element_text(margin = margin(r = 10))
  ) +
  scale_x_continuous(limits = c(2009, 2023), 
                     breaks = seq(2009, 2023, by = 2))+
  scale_y_continuous(limits = c(0, 7),
                     breaks = seq(0, 7, by = 1))+
  guides(color = guide_legend(nrow = 1))+
  geom_text(data = subset(lbs_t, industry == 0 & year == 2023), 
            aes(x = year, y = lbs_average, label = "Total"), 
            color = "black", hjust = 0.5, vjust = -1, size = 4)

# Table 7: Distribution of Labor Shortage Rates by Firm Size and Industry

lbs_d <- read_dta("lbs.dta")

industry_order <- lbs_d %>%
  group_by(industry) %>%
  summarize(avg_labor_shortage = mean(labor_shortage_rate, na.rm = TRUE)) %>%
  arrange(avg_labor_shortage) %>%
  pull(industry)

lbs_d$industry <- factor(lbs_d$industry, levels = industry_order)

ggplot(lbs_d, aes(x = as.factor(fsize), y = industry, fill = labor_shortage_rate)) +
  geom_tile() +
  scale_fill_gradientn(colors = c("white", "black"), limits = c(0, 8)) +
  labs(y = "Industrial Category", x = "Size of Firm", fill = "Labor Shortage Rate") +
  theme_minimal() +
  theme(legend.position = "top",
        legend.background = element_rect(color = "black", fill = "white"),
        legend.box.margin = margin(2, 2, 2, 2),
        legend.key.height = unit(4, "mm"),
        legend.spacing.x = unit(2, "pt")) +
  scale_x_discrete(labels = c("5~9", "10~29", "30~99", "100~299", "299~"))

# Figure A1: Average Labor Shortage Rate by Industry (2009~2023)

lbs_d <- read_dta("lbs.dta")

ggplot(lbs_d, aes(x = year, y = lbs_average,  group = industry, color = factor(cluster, levels = c(2, 4, 1, 3)))) +
  geom_line(alpha = 0.4, linetype = "dashed", size = 1) +
  geom_line(data = subset(lbs_t, industry == 0), aes(x = year, y = lbs_average), 
            color = "black", alpha = 1, size = 1.5) +
  labs(x = "Year", y = "Average in Labor Shortage Rate (%)") +
  theme_minimal()+
  scale_color_manual(
    name = "Cluster", 
    values = c("#4169E1", "#009900" ,"#FF4500", "#AA0011"),
    labels = c("1", "2", "3", "4")) +
  theme(legend.position = "top",
        legend.background = element_rect(color = "black", fill = "white"),
        legend.box.margin = margin(1, 1, 1, 1),
        legend.spacing.x = unit(2, "pt"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        plot.margin = margin(0.2, 0.2, 0.2, 0.2, "cm"),
        axis.title.y = element_text(margin = margin(r = 10)),
        axis.text.y = element_text(margin = margin(r = 10))
  ) +
  guides(color = guide_legend(nrow = 1)) +
  scale_x_continuous(limits = c(2009, 2023), 
                     breaks = seq(2009, 2023, by = 2))+
  scale_y_continuous(limits = c(0, 7),
                     breaks = seq(0, 7, by = 1))+
  geom_text(data = subset(lbs_t, industry == 0 & year == 2023), 
            aes(x = year, y = lbs_average, label = "Total"), 
            color = "black", hjust = 0.5, vjust = -1, size = 4)

# Figure A2: Cluster Dendrogram of Labor Shortage Rates (2009~2023) with clustering process

lbs_wide <- lbs %>%
  select(industry, year, lbs_average) %>%
  spread(key = year, value = lbs_average)

dist_matrix <- dist(lbs_wide[, -1], method = "euclidean")
hc <- hclust(dist_matrix, method = "ward.D2")

lbs_wide$cluster_original <- cutree(hc, k = 4)

cluster_order <- lbs %>%
  left_join(lbs_wide[, c("industry", "cluster_original")], by = "industry") %>%
  group_by(cluster_original) %>%
  summarise(avg_lbs = mean(lbs_average, na.rm = TRUE)) %>%
  arrange(avg_lbs) %>%
  mutate(cluster = row_number()) 

lbs_wide <- lbs_wide %>%
  left_join(cluster_order[, c("cluster_original", "cluster")], by = "cluster_original")

plot(hc,
     labels = lbs_wide$industry,
     main = "Hierarchical Clustering of Industries")
rect.hclust(hc, k = 4, border = "red")