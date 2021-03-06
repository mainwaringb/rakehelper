# Computing only rake weights
# EG, for a survey conducted with simple random sampling
gles17$simple_weight <- rakew8(design = gles17, targets = list(
    gender = c("Male" = .495, "Female" = .505),
    eastwest = c("East Germany" = .195, "West Germany" = .805)
))

# Computing rake weights after design weights
# EG, for a survey with complex sampling design
gles17_dweighted <- svydesign(ids = gles17$vpoint, weights = gles17$dweight, 
    strata = gles17$eastwest, data = gles17, nest = TRUE)
gles17_raked <- rakesvy(design = gles17_dweighted, targets = list(
    gender = c("Male" = .495, "Female" = .505),
    agecat = c("<=29" = .16, "30-39" = .15, "40-49" = .15, 
        "50-59" = .19, "60-69" = .15, ">=70" = .21)
))

# With unnamed target levels, using match.levels.by = "order"
rakew8(design = gles17, targets = list(
    gender = c(.495, .505),
    eastwest = c(.195, .805)),
    match.levels.by = "order"
)

# With dataframe targets specifying counts (format used by 'rake') 
# Targets are matched to dataset variables based on target column name
targets_df = list(
    data.frame(
        gender = c("Male", "Female"), 
        Freq = c(1485, 1515)),
    data.frame(
        eastwest = c("East Germany", "West Germany"), 
        Freq = c(585, 2415))
)
rakew8(design = gles17, targets = targets_df, 
    match.vars.by = "colname", samplesize = "from.targets")

