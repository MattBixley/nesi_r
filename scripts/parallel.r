### tidymodels bootstramp example to test that multiple cores

library(tidyverse)
library(tidymodels)
library(palmerpenguins)
library(ranger)
library(doParallel)
# devtools::install_github("G-Thomson/Manu")
library(Manu)

penguins %>%
  filter(!is.na(sex)) %>%
  ggplot(aes(flipper_length_mm, bill_length_mm, color = sex, size = body_mass_g)) +
  geom_point(alpha = 0.5) +
  facet_wrap(~species)

penguins_df <- penguins %>%
  filter(!is.na(sex)) %>%
  select(-year, -island)

set.seed(123)
penguin_split <- initial_split(penguins_df, strata = sex)
penguin_train <- training(penguin_split)
penguin_test <- testing(penguin_split)

# function for iterating the model
cores_test <- function(cores = 2, boot = 100){  

# create the bootstrap samples
set.seed(123)
penguin_boot <- bootstraps(penguin_train, times = boot)
  
glm_spec <- logistic_reg() %>%
    set_engine("glm")
  #glm_spec
  
rf_spec <- rand_forest() %>%
    set_mode("classification") %>%
    set_engine("ranger")
  #rf_spec
  
penguin_wf <- workflow() %>%
    add_formula(sex ~ .)
  #penguin_wf

# register the parallel backend    
cl <- makeCluster(cores)
registerDoParallel(cl)

# repeat each test 10 times
time <- numeric(10)
for(i in 1:10){
 
  start <- Sys.time()

  # glm model
  glm_rs <- penguin_wf %>%
    add_model(glm_spec) %>%
    fit_resamples(
      resamples = penguin_boot,
      control = control_resamples(save_pred = TRUE)
    )
  
  # random forest model
  rf_rs <- penguin_wf %>%
    add_model(rf_spec) %>%
    fit_resamples(
      resamples = penguin_boot,
      control = control_resamples(save_pred = TRUE)
    )
  
  end <- Sys.time()
  time[i] <- end - start
  return(time)
}
stopCluster(cl)
}


### run the fit with different cpus
cores <- 2
cores_result <- data.frame(matrix(NA, nrow = cores, ncol = 3))
names(cores_result) <- c("cores", "time_mean", "time_var" )

for (j in 1:cores){
  
  time <- cores_test(cores = j, boot = 200)
  cores_result[j,1] <- j
  cores_result[j,2] <- round(mean(time),3)
  cores_result[j,3] <- round(var(time),3)
  
}

cores_result

# Select n colours from the Kakapo palette
selected_colours <- get_pal("Kaka")

ggplot(cores_result, aes(x = cores, y = time_mean)) +
  geom_line(col = selected_colours[1], linewidth =1.1) +
  geom_point(col = selected_colours[2], size = 3, alpha = 0.8) +
  labs(x = "Number of cores", y = "Time in seconds") +
  ggtitle("Boostrapping Cores vs Run Time\nmean of 10 replicates") +
  theme_minimal()

#glm_rs
#rf_rs

#collect_metrics(rf_rs)
#collect_metrics(glm_rs)
 
#glm_rs %>%
#  conf_mat_resampled()

#penguin_final <- penguin_wf %>%
#  add_model(glm_spec) %>%
#  last_fit(penguin_split)

#penguin_final

#collect_predictions(penguin_final) %>%
#  conf_mat(sex, .pred_class)

#penguin_final$.workflow[[1]] %>%
#  tidy(exponentiate = TRUE)


