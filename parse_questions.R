parse_questions <- function(questions, seed = NULL) {
  require(stringr)
  require(dplyr)
  if (!is.null(seed)) set.seed(seed)
  lapply(seq_along(questions), function(i, questions) {
    ## pull question and answers from list of questions
    question <- questions[[i]]$question
    answers <- c(questions[[i]]$incorrect, questions[[i]]$correct)
    correct <- questions[[i]]$correct
    
    ## randomize answers
    randomized_answers <- sample(answers, length(answers))
    
    ## don't randomize true-false questions
    ## True should always come first
    if (correct == "True" || correct == "False") { 
      randomized_answers <- c("True", "False")
    }

    ## generate letters for answers
    letters_to_use <- letters[1:length(answers)]
    
    ## generate question and answer strings
    question_string <- str_c(i, ". ", question)
    answer_strings <- Map(str_c, "\t", letters_to_use, ". ", randomized_answers)
    answer_string <- str_c(answer_strings, collapse = "\n")

    ## combine question and answer strings 
    exam_string <- str_c(question_string, answer_string, sep = "  \n")
    
    ## generate answer key 
    correct_answer_index <- which(str_detect(answer_strings, correct))
    
    ## long version
    ## bold the correct answer
    ## (can't bold the letter in Markdown lists...)
    answers_show_correct <- answer_strings
    answers_show_correct[correct_answer_index] <- 
      str_replace(answers_show_correct[correct_answer_index], 
                  "(\t[:alpha:]. )", "\\1**") %>%
      str_c("**")
    answers_show_correct_string <- str_c(answers_show_correct, collapse = "\n")
    answer_key_long_string <- 
      str_c(question_string, answers_show_correct_string, sep = "  \n")
    
    ## short version
    correct_answer_letter <- 
      letters_to_use[which(str_detect(answer_strings, correct))]
    answer_key_short_string <- str_c(i, ". ", correct_answer_letter)
    
    ## for each question, return a list with three named components
    list(exam = exam_string, 
         answer_key_long = answer_key_long_string, 
         answer_key_short = answer_key_short_string)
  }, questions) %>% 
    bind_rows()  # convert to data frame and return
}

print_questions <- function(parsed_questions) {
  require(stringr)
  parsed_questions$exam %>%
    str_c(collapse = "  \n  \\  \n") %>%
    cat()
}

print_answer_key_long <- function(parsed_questions) {
  require(stringr)
  parsed_questions$answer_key_long %>%
    str_c(collapse = "  \n  \\  \n") %>%
    cat()
}

print_answer_key_short <- function(parsed_questions) {
  require(stringr)
  parsed_questions$answer_key_short %>%
    str_c(collapse = "\n") %>%
    cat()
}

randomize_questions <- function(questions, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)
  sample(questions, size = length(questions))
}