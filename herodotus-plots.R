# load libraries ----
library(tidyverse)
library(janitor)
library(extrafont)
library(gganimate)
library(gifski)
library(Cairo)

# font_import() # run this once
loadfonts(device = "win")
CairoWin()

# load data ----
df <- read_csv("data/F_app_and_height_vs_delta.csv") |> 
  clean_names()

theme_set(
  theme_minimal(base_size = 16) + 
    theme(
      text = element_text(family = "Segoe UI Light"), #, face = "italic")
      panel.border = element_rect(color = "black", linewidth = 1, fill = NA)
    )
)


# final row has some NAs

# plot 1 ----
(gg1 <- df |> 
   ggplot(
     aes(x = delta_cm,
         y = f_app_over_g_kg)
   ) +
   geom_line(size = 2, color = "#EA7580") + 
   labs(
     x = expression(paste(delta, " (cm)")),
     y = expression(paste(F["app"]/g, " (kg)"))
   )) 

gg_animate1 <- gg1 +
  transition_reveal(delta_cm) +
  view_follow(fixed_y = TRUE,
              fixed_x = FALSE)

# Save animation
animate(
  gg_animate1,
  height = 400, width = 600, fps = 30, duration = 10,
  end_pause = 120, rewind = FALSE,
  renderer = gifski_renderer()
)

anim_save("plot1.gif")

# plot 2 ----
(gg2 <- df |> 
  ggplot(
    aes(x = delta_cm,
        y = delta_height_cm)
  ) +
  geom_line(size = 2, color = "#088BBE") +
  labs(
    x = expression(paste(delta, " (cm)")),
    y = "height (cm)"
  ))

gg_animate2 <- gg2 +
  transition_reveal(delta_cm) +
  view_follow(fixed_y = TRUE,
              fixed_x = FALSE)

# Save animation
animate(
  gg_animate2,
  height = 400, width = 600, fps = 30, duration = 10,
  end_pause = 120, rewind = FALSE,
  renderer = gifski_renderer()
)

anim_save("plot2.gif")

