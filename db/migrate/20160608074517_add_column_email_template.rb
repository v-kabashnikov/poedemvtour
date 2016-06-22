class AddColumnEmailTemplate < ActiveRecord::Migration
  def change
    EmailTemplate.create(
      title: 'Создан новый вопрос (телефон)',
      slug: 'feedback_phone',
      subject: 'Создан новый вопрос (телефон)'
    )
  end
end
