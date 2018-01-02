# frozen_string_literal: true

require 'rails_helper'

describe 'teachers', type: :request do
  let(:headers) do
    {
      'Accept' => 'application/vnd.api+json',
      'Content-Type' => 'application/vnd.api+json'
    }
  end
  let(:params) { { teacher: teacher }.to_json }

  subject do
    request!

    response
  end

  describe 'GET index' do
    before do
      teachers
    end

    let(:request!) { get teachers_path, headers: headers }

    context 'when there are no teachers' do
      let(:teachers) {}

      it { is_expected.to have_http_status(:ok) }
      it 'should return an empty array' do
        body = JSON.parse(subject.body)

        expect(body).to be_empty
      end
    end

    context 'when there are teachers' do
      let(:teachers) { create_list(:teacher, 2) }

      it { is_expected.to have_http_status(:ok) }
      it 'should return a list of teachers' do
        body = JSON.parse(subject.body)

        expect(body.size).to eq(teachers.size)

        body.each_with_index do |teacher, index|
          expect(teacher['id']).to eq(teachers[index].id)
          expect(teacher['first_name']).to eq(teachers[index].first_name)
          expect(teacher['grade']).to eq(teachers[index].grade.to_s)
          expect(teacher['is_active']).to eq(teachers[index].is_active)
          expect(teacher['last_name']).to eq(teachers[index].last_name)
        end
      end
    end
  end

  describe 'GET show' do
    before do
      teacher_id
    end

    let(:request!) { get teacher_path(teacher_id) }

    context 'when the teacher can be found' do
      let(:teacher) { create(:teacher) }
      let(:teacher_id) { teacher.id }

      it { is_expected.to have_http_status(:ok) }
      it 'should return a teacher' do
        body = JSON.parse(subject.body)

        expect(body['id']).to eq(teacher.id)
        expect(body['first_name']).to eq(teacher.first_name)
        expect(body['grade']).to eq(teacher.grade.to_s)
        expect(body['is_active']).to eq(teacher.is_active)
        expect(body['last_name']).to eq(teacher.last_name)
      end
    end

    context 'when the teacher can not be found' do
      let(:teacher_id) { SecureRandom.uuid }

      it { is_expected.to have_http_status(:not_found) }
      it 'should return an error message' do
        body = JSON.parse(subject.body)

        expect(body).to eq("Couldn't find Teacher with 'id'=#{teacher_id}")
      end
    end
  end

  describe 'POST create' do
    let(:request!) do
      post teachers_path,
           params: params,
           headers: headers
    end

    context 'when the teacher attributes are valid' do
      let(:teacher) { attributes_for(:teacher) }

      it { is_expected.to have_http_status(:ok) }
      it 'should return a success message' do
        message = JSON.parse(subject.body)['message']

        expect(message).to eq(I18n.t('teachers.create.success'))
      end
    end

    context 'when the teacher attributes are not valid' do
      let(:teacher) { attributes_for(:teacher, first_name: nil) }

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it 'should return a success message' do
        message = JSON.parse(subject.body)['message']

        expect(message).to eq(I18n.t('teachers.create.failure'))
      end
    end
  end

  describe 'PATCH update' do
    let(:request!) do
      patch teacher_path(teacher_id),
            params: params,
            headers: headers
    end

    context 'when the teacher is valid' do
      let(:params) do
        {
          teacher: { last_name: teacher.first_name }
        }.to_json
      end
      let(:teacher) { create(:teacher) }
      let(:teacher_id) { teacher.id }

      it { is_expected.to have_http_status(:ok) }
      it 'they see a success message' do
        body = JSON.parse(subject.body)

        expect(body['message']).to eq(I18n.t('teachers.update.success'))
        expect(body['resource']['last_name']).to eq(teacher.first_name)
      end
    end

    context 'when the teacher is not valid' do
      let(:params) do
        {
          teacher: { is_active: 'test' }
        }.to_json
      end
      let(:teacher) { create(:teacher) }
      let(:teacher_id) { teacher.id }

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it 'should return a success message' do
        message = JSON.parse(subject.body)['message']

        expect(message).to eq(I18n.t('teachers.update.failure'))
      end
    end

    context 'when the teacher is not found' do
      let(:params) do
        {
          teacher: { last_name: teacher.first_name }
        }.to_json
      end
      let(:teacher) { create(:teacher) }
      let(:teacher_id) { SecureRandom.uuid }

      it { is_expected.to have_http_status(:not_found) }
      it 'should return an error message' do
        body = JSON.parse(subject.body)

        expect(body).to eq("Couldn't find Teacher with 'id'=#{teacher_id}")
      end
    end
  end
end
