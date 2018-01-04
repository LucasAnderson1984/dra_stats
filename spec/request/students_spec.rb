# frozen_string_literal: true

require 'rails_helper'

describe 'students', type: :request do
  let(:headers) do
    {
      'Accept' => 'application/vnd.api+json',
      'Content-Type' => 'application/vnd.api+json'
    }
  end
  let(:params) { { student: student }.to_json }

  subject do
    request!

    response
  end

  describe 'GET index' do
    before do
      students
    end

    let(:request!) { get students_path, headers: headers }

    context 'when there are no students' do
      let(:students) {}

      it { is_expected.to have_http_status(:ok) }
      it 'should return an empty array' do
        body = JSON.parse(subject.body)

        expect(body).to be_empty
      end
    end

    context 'when there are students' do
      let(:students) { create_list(:student, 2) }

      it { is_expected.to have_http_status(:ok) }
      it 'should return a list of students' do
        body = JSON.parse(subject.body)

        expect(body.size).to eq(students.size)

        body.each_with_index do |student, index|
          expect(student['id']).to eq(students[index].id)
          expect(student['first_name']).to eq(students[index].first_name)
          expect(student['grade']).to eq(students[index].grade.to_s)
          expect(student['is_active']).to eq(students[index].is_active)
          expect(student['last_name']).to eq(students[index].last_name)
        end
      end
    end

    context 'when viewing a teachers students' do
      let(:request!) do
        get teacher_students_path(teacher_one), headers: headers
      end
      let!(:student_two) { create(:student, teacher_id: teacher_two.id) }
      let!(:students) { create_list(:student, 2, teacher_id: teacher_one.id) }
      let!(:teacher_one) { create(:teacher) }
      let!(:teacher_two) { create(:teacher) }

      it { is_expected.to have_http_status(:ok) }
      it 'should return the teachers students' do
        body = JSON.parse(subject.body)

        expect(body.size).to eq(students.size)
        body.each_with_index do |student, index|
          expect(student['id']).to eq(students[index].id)
          expect(student['first_name']).to eq(students[index].first_name)
          expect(student['grade']).to eq(students[index].grade.to_s)
          expect(student['is_active']).to eq(students[index].is_active)
          expect(student['last_name']).to eq(students[index].last_name)

          expect(student['id']).not_to eq(student_two.id)
        end
      end
    end
  end

  describe 'GET show' do
    before do
      student_id
    end

    let(:request!) { get student_path(student_id) }

    context 'when the student can be found' do
      let(:student) { create(:student) }
      let(:student_id) { student.id }

      it { is_expected.to have_http_status(:ok) }
      it 'should return a student' do
        body = JSON.parse(subject.body)

        expect(body['id']).to eq(student.id)
        expect(body['first_name']).to eq(student.first_name)
        expect(body['grade']).to eq(student.grade.to_s)
        expect(body['is_active']).to eq(student.is_active)
        expect(body['last_name']).to eq(student.last_name)
      end
    end

    context 'when the student can not be found' do
      let(:student_id) { SecureRandom.uuid }

      it { is_expected.to have_http_status(:not_found) }
      it 'should return an error message' do
        body = JSON.parse(subject.body)

        expect(body).to eq("Couldn't find Student with 'id'=#{student_id}")
      end
    end
  end

  describe 'POST create' do
    let(:request!) do
      post students_path,
           params: params,
           headers: headers
    end

    context 'when the student attributes are valid' do
      let(:student) { attributes_for(:student, teacher_id: teacher.id) }
      let(:teacher) { create(:teacher) }

      it { is_expected.to have_http_status(:ok) }
      it 'should return a success message' do
        message = JSON.parse(subject.body)['message']

        expect(message).to eq(I18n.t('students.create.success'))
      end
    end

    context 'when the student attributes are not valid' do
      let(:student) { attributes_for(:student) }

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it 'should return a success message' do
        message = JSON.parse(subject.body)['message']

        expect(message).to eq(I18n.t('students.create.failure'))
      end
    end
  end

  describe 'PATCH update' do
    let(:request!) do
      patch student_path(student_id),
            params: params,
            headers: headers
    end

    context 'when the student is valid' do
      let(:middle_name) { Faker::Name.first_name }
      let(:params) do
        {
          student: { middle_name: middle_name }
        }.to_json
      end
      let(:student) { create(:student, teacher_id: teacher.id) }
      let(:student_id) { student.id }
      let(:teacher) { create(:teacher) }

      it { is_expected.to have_http_status(:ok) }
      it 'they see a success message' do
        body = JSON.parse(subject.body)

        expect(body['message']).to eq(I18n.t('students.update.success'))
        expect(body['resource']['middle_name']).to eq(middle_name)
      end
    end

    context 'when the student is not valid' do
      let(:params) do
        {
          student: { is_active: 'test' }
        }.to_json
      end
      let(:student) { create(:student, teacher_id: teacher.id) }
      let(:student_id) { student.id }
      let(:teacher) { create(:teacher) }

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it 'should return a success message' do
        message = JSON.parse(subject.body)['message']

        expect(message).to eq(I18n.t('students.update.failure'))
      end
    end

    context 'when the student is not found' do
      let(:middle_name) { Faker::Name.first_name }
      let(:params) do
        {
          student: { middle_name: middle_name }
        }.to_json
      end
      let(:student) { create(:student, teacher_id: teacher.id) }
      let(:student_id) { SecureRandom.uuid }
      let(:teacher) { create(:teacher) }

      it { is_expected.to have_http_status(:not_found) }
      it 'should return an error message' do
        body = JSON.parse(subject.body)

        expect(body).to eq("Couldn't find Student with 'id'=#{student_id}")
      end
    end
  end
end
