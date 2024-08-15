### Packages
library(doParallel)
library(tidyverse)
library(tidymodels)
library(palmerpenguins)
library(ranger)

### Data for modelling
penguins_df <- penguins %>% drop_na() %>% select(-year)

### Split into train and test
penguin_split <- initial_split(penguins_df, strata = species)
penguin_train <- training(penguin_split)
penguin_test <- testing(penguin_split)

### Define Random Forest Model
rf_spec <- rand_forest(trees = 1000,
                       mtry = tune(),
                       min_n = tune()) %>% 
  set_mode("classification") %>% 
  set_engine("ranger")

### Cross Validation Sets to tune RF
penguin_cv <- vfold_cv(penguins_df, strata = species)

### Add formula and model together with workflow
tune_wf <- workflow() %>% 
  add_formula(species ~ .) %>% 
  add_model(rf_spec)

### Parallel Function for Model Tuning
parallel_rf <- function(cores = 2, grid = 20){
  numCores <- cores
  cl <- makeCluster(numCores)
  registerDoParallel(cl)
 
  ### Tune HyperParameters
  start_time <- Sys.time()
  rf_tune <- tune_grid(
    tune_wf,
    resamples = penguin_cv,
    control = control_resamples(save_pred = TRUE),
    grid = grid
  )
  rf_tune
  end_time <- Sys.time()
   
  ### Stop Cluster
  stopCluster(cl)
  
  return(paste0("Tuning time with ", numCores, " cores is ", round(end_time - start_time, 2), " seconds"))
  
}

# 1 core, grid = 8
parallel_rf(1,8)
