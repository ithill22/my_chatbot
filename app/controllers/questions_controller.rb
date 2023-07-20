class QuestionsController < ApplicationController
  def index
  end

  def create
    @answer = find_answer(params[:question][:question].downcase)
  end

  private

  def find_answer(question)
    resume_info = ResumeInfo.find_by(question: question.downcase)
    if resume_info
      return resume_info.answer
    else
      relevant_answer = find_relevant_answer(question.downcase)
      return relevant_answer || "I don't have the information you are looking for."
    end
  end

  def find_relevant_answer(question)
    keywords = question.split(" ")
    relevant_answers = ResumeInfo.where("LOWER(answer) LIKE ?", "%#{keywords[0]}%")
    keywords.drop(1).each do |keyword|
      relevant_answers = relevant_answers.or(ResumeInfo.where("LOWER(answer) LIKE ?", "%#{keyword}%"))
    end

    if relevant_answers.any?
      most_relevant_answer = relevant_answers.max_by { |answer| keywords.count { |keyword| answer.answer.downcase.include?(keyword) } }
      return most_relevant_answer.answer
    end

    nil
  end
end