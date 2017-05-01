module JobsHelper

  def render_job_description(job)
		simple_format(job.description)
	end  

  def render_highlight_content(job,query_string)
    excerpt_cont = excerpt(job.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end

end
