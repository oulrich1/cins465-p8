module ProjectsHelper
    def log_test(message)
        Rails.logger.info(message)
        # puts message
    end
end
