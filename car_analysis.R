install.packages("ggplot2")
# 加载 ggplot2 包，用于绘制精美图表
library(ggplot2)
# 查看 mtcars 数据集的前几行
head(mtcars)

# 查看 mtcars 数据集的结构（列名和数据类型）
str(mtcars)
# 绘制散点图，探索汽车重量和每加仑里程的关系
# 用气缸数区分颜色，用马力区分点的大小

ggplot(data = mtcars,            # 我们的数据源是 mtcars
       mapping = aes(x = wt,     # X轴映射到汽车重量 (wt)
                     y = mpg,    # Y轴映射到每加仑里程 (mpg)
                     color = as.factor(cyl), # 颜色映射到气缸数 (cyl)，as.factor()很重要！
                     size = hp)) + # 点的大小映射到马力 (hp)
  geom_point() +   # 添加散点图层
  labs(title = "汽车重量、油耗、气缸数与马力关系", # 添加图表标题
       x = "汽车重量 (千磅)",               # X轴标签
       y = "每加仑里程 (mpg)",                # Y轴标签
       color = "气缸数",                     # 图例标题：颜色代表什么
       size = "马力")                      # 图例标题：大小代表什么

ggplot(data = mtcars, 
       # 全局映射：X轴、Y轴、颜色是大家都要遵守的
       mapping = aes(x = wt, 
                     y = mpg, 
                     color = as.factor(cyl))) + 
  
  # 局部映射：只有画“点”的时候，才根据马力改变大小！
  geom_point(mapping = aes(size = hp)) + 
  
  # 画趋势线：它不会再收到关于 size 的干扰了
  geom_smooth(method = "lm", se = FALSE) +  
  
  labs(title = "汽车重量、油耗、气缸数与马力关系",
       x = "汽车重量 (千磅)", 
       y = "每加仑里程 (mpg)", 
       color = "气缸数", 
       size = "马力")
# --- 进阶分析：线性回归模型 ---
# 我们想量化：每增加 1000 磅重量，每加仑里程(mpg)平均会减少多少？

# 建立线性模型：mpg = 截距 + 斜率 * wt
car_model <- lm(mpg ~ wt, data = mtcars)

# 查看模型的详细统计结果
summary(car_model)

# 在图表上添加回归方程的信息（这会输出到控制台）
print("模型分析完毕：负相关系数已计算。")

